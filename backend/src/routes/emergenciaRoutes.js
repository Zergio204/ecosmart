const express = require('express');
const router = express.Router();
const emergenciaController = require('../controllers/emergenciaController');

router.post('/', emergenciaController.reportarEmergencia);
router.get('/', emergenciaController.listarEmergencias);

module.exports = router;