const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const bodyParser = require("body-parser");
require("dotenv").config();

const authRoutes = require("./routes/auth");
const healthRoutes = require("./routes/health");

const app = express();
app.use(cors());
app.use(bodyParser.json());

app.use("/api/auth", authRoutes);
app.use("/api/health", healthRoutes);

mongoose
  .connect(
    "mongodb+srv://vineet:Optacloud123@healthdata.f7ocs.mongodb.net/healthData?retryWrites=true&w=majority&appName=healthData"
  )
  .then(() => {
    app.listen(process.env.PORT, () =>
      console.log(`Server running on port ${process.env.PORT}`)
    );
  })
  .catch((error) => console.error(error));
