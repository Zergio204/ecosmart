const express = require('express');
const router = express.Router();
const rutaController = require('../controllers/rutaController');

// Rutas para gestión de rutas de recogida
router.post('/', rutaController.crearRuta); // Crear ruta óptima
router.get('/', rutaController.listarRutas); // Listar rutas
router.delete('/:id', rutaController.eliminarRuta);
router.get('/:id', rutaController.getRuta);

module.exports = router;