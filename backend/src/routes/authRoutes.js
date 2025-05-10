const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const { verificarToken } = require('../middlewares/authMiddleware');

router.post('/register', async (req, res) => {
  const { username, email, password } = req.body;

  try {
    // Validar y guardar el usuario en la base de datos
    const user = await User.create({
      username,
      email,
      password,
    });

    res.status(201).json({ message: 'Usuario registrado correctamente' });
  } catch (error) {
    res.status(500).json({ error: 'Error al registrar usuario' });
  }
});
router.post('/login', authController.login);
router.get('/perfil', verificarToken, (req, res) => {
  res.json({ usuario: req.usuario });
});

module.exports = router;