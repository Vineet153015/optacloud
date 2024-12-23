const healthRecord = require("../models/healthrecord");

exports.addHealthRecord = async (req, res) =>{
    const {heartRate, steps} = req.body;
    try{
        const record = new healthRecord({userId: req.user.id, heartRate, steps});
        await record.save();
        res.status(201).json(record);
    } catch (error) {
        res.status(400).json({error : error.message});
    }
};

exports.getHealthRecords = async (req, res) => {
    try {
        const records = await healthRecord.find({ userId: req.user.id });
        res.json(records);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
};