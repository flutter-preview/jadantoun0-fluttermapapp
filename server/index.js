const express = require('express');
const mongoose = require('mongoose')
const Location = require('./models/Location');
require('dotenv').config()

const app = express();

app.get("/", (req, res) => {
    res.json({message: "Working"});
})


app.get("/locations", async (req, res) => {
    try {
        const locations = await Location.find({})
        res.json(locations)
    } catch(err) {
        console.log(err);
        res.status(500).json({errorMessage: "Internal server error occured"})
    }
})


const PORT = 3001

mongoose.connect(process.env.MONGODB_URL, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
}).then(() => {
    console.log("Connected to database");
   app.listen(PORT, "0.0.0.0", () => {
        console.log(`Backend running on port ${PORT}`);
    }) 
})
