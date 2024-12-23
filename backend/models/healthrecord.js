const mongoose = require("mongoose");

const HealthdataSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required:true
    },

    heartRate : {
        type: Number,
        required: true
    },

    step: {
        type: Number,
        required: true
    },

    timestamp:{
        type: Date,
        default: Date.now
    }
});

module.exports = mongoose.model("HealthRecord", HealthdataSchema);