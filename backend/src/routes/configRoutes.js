const express = require('express');
const router = express.Router();
const configController = require('../controllers/configController');

router.post('/umbrales', configController.actualizarUmbrales); // ¡Definir ruta!

module.exports = router;