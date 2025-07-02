const express = require('express');
const loginUser = require("../controllers/login");
const registerUser = require("../controllers/register");
const getEventData = require("../controllers/getEventData");

const router = express.Router();
router.post('/login', loginUser);
router.post('/register', registerUser);
router.get('/getEventData', getEventData);

module.exports = router;