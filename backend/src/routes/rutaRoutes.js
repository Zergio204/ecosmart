const express = require('express');
const router = express.Router();
const rutaController = require('../controllers/rutaController');

// Rutas para gestión de rutas de recogida
router.post('/rutas', rutaController.crearRuta); // Crear ruta óptima
router.get('/rutas', rutaController.listarRutas); // Listar rutas

module.exports = router;