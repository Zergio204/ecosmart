const express = require('express');
const router = express.Router();
const contenedorController = require('../controllers/contenedorController');

router.post('/contenedores', contenedorController.crearContenedor); // Ruta POST
router.get('/contenedores', contenedorController.listarContenedores);

module.exports = router;