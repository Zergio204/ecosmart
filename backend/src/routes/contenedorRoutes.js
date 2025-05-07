const express = require('express');
const router = express.Router();
const contenedorController = require('../controllers/contenedorController');

router.get('/contenedores', contenedorController.listarContenedores);

module.exports = router;