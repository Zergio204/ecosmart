const express = require('express');
const router = express.Router();
const contenedorController = require('../controllers/contenedorController');

router.get('/', contenedorController.listarContenedores);
router.post('/', contenedorController.crearContenedor);
router.post('/:id/recoger', contenedorController.marcarRecogido);

module.exports = router;