const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const { verificarToken } = require('../middlewares/authMiddleware');

router.post('/registro', authController.registro);
router.post('/login', authController.login);
router.get('/perfil', verificarToken, (req, res) => {
  res.json({ usuario: req.usuario });
});

module.exports = router;