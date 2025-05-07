const express = require('express');
const router = express.Router();
const emergenciaController = require('../controllers/emergenciaController');

router.post('/emergencias', emergenciaController.reportarEmergencia);
router.get('/emergencias', emergenciaController.listarEmergencias);

module.exports = router;