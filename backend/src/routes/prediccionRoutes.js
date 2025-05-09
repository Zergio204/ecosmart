// src/routes/prediccionRoutes.js
const express = require('express');
const router = express.Router();
const prediccionController = require('../controllers/prediccionController');

router.post('/:id', prediccionController.generarPrediccion);

module.exports = router;