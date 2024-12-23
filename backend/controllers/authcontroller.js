const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/user");

exports.register = async (req, res) => {
  const { name, email, password } = req.body;
  try {
    const hashedPassword = await bcryptjs.hash(password, 10);
    const user = new User({ name, email, password: hashedPassword });
    await user.save();
    res.status(201).json({ message: "User registered successfully" });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

exports.login = async (req, res) => {
  const { email, password } = req.body;
  try {
    const user = await User.findOne({ email });
    if (!user) return res.status(404).json({ error: "User not found" });

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ error: "Invalid credentials" });

    const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, {
      expiresIn: "1h",
    });
    res.json({ token, user });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};
