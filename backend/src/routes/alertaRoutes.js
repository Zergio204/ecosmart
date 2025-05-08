const express = require('express');
const router = express.Router();
const alertaController = require('../controllers/alertaController');

// Rutas para alertas
router.get('/alertas', alertaController.listarAlertas);
router.post('/alertas/:id/resolver', alertaController.marcarAlertaResuelta);

module.exports = router;