const express = require("express");
const { addHealthRecord, getHealthRecords } = require("../controllers/healthcontroller");
const authMiddleware = require("../middleware/authMiddleware");
const router = express.Router();

router.post("/", authMiddleware, addHealthRecord);
router.get("/", authMiddleware, getHealthRecords);

module.exports = router;
