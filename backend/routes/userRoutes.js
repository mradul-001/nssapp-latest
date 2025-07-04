const express = require('express');
const loginUser = require("../controllers/login");
const registerUser = require("../controllers/register");
const eventsToday = require("../controllers/eventsToday");
const addEvent = require("../controllers/addEvent");
const allEvents = require("../controllers/allEvents");

const router = express.Router();
router.post('/login', loginUser);
router.post('/register', registerUser);
router.post('/eventsToday', eventsToday);
router.post('/addEvent', addEvent);
router.post('/allEvents', allEvents);

module.exports = router;