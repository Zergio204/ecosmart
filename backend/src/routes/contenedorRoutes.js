const express = require('express');
const router = express.Router();
const contenedorController = require('../controllers/contenedorController');

router.get('/', contenedorController.listarContenedores);
router.post('/', contenedorController.crearContenedor);
router.get('/:id', contenedorController.detalleContenedor);
router.post('/:id/recoger', contenedorController.marcarRecogido);
router.put('/:id', contenedorController.actualizarContenedor);
router.delete('/:id', contenedorController.eliminarContenedor);

module.exports = router;