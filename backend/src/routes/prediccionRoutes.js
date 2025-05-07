const express = require('express');
const router = express.Router();
const prediccionController = require('../controllers/prediccionController');

router.post('/predicciones/:id', prediccionController.generarPrediccion);
module.exports = router;