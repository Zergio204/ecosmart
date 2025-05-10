const express = require('express');
const router = express.Router();
const configController = require('../controllers/configController');

router.post('/umbrales', configController.actualizarUmbrales);
router.get('/umbrales', configController.obtenerUmbrales);

module.exports = router;