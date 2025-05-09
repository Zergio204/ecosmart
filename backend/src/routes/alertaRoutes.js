const express = require('express');
const router = express.Router();
const alertaController = require('../controllers/alertaController');

router.get('/', alertaController.listarAlertas); // GET /api/alertas
router.post('/:id/resolver', alertaController.marcarAlertaResuelta); // POST /api/alertas/1/resolver

module.exports = router;