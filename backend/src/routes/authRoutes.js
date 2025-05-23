const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const { verificarToken } = require('../middlewares/authMiddleware');

// Registro de usuario
router.post('/register', authController.registro);

// Login
router.post('/login', authController.login);

// Perfil del usuario (protegido por token)
router.get('/perfil', verificarToken, (req, res) => {
  res.json({ usuario: req.usuario });
});

router.put('/users/update', authController.updateUserProfile);

router.get('/users/current', authController.getCurrentUser);

// Actualizar perfil del usuario
router.post('/forgot-password', authController.sendVerificationCode);
router.post('/reset-password', authController.resetPassword);

module.exports = router;