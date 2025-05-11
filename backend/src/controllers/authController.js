const Usuario = require('../models/Usuario');
const VerificationCode = require('../models/VerificationCode');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

exports.registro = async (req, res) => {
  try {
    const { nombre, email, contraseña } = req.body;

    // Hashear contraseña
    const hashedPassword = await bcrypt.hash(contraseña, 10);

    // Crear usuario
    const usuario = await Usuario.create({
      nombre,
      email,
      contraseña: hashedPassword,
      rol: req.body.rol || 'ciudadano',
    });

    res.status(201).json({ mensaje: 'Usuario creado' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.login = async (req, res) => {
  try {
    const { email, contraseña } = req.body;
    const usuario = await Usuario.findOne({ where: { email } });

    if (!usuario) {
      return res.status(404).json({ error: 'Usuario no encontrado' });
    }

    const match = await bcrypt.compare(contraseña, usuario.contraseña);
    if (!match) {
      return res.status(401).json({ error: 'Contraseña incorrecta' });
    }

    const token = jwt.sign(
      { id: usuario.id, rol: usuario.rol },
      process.env.JWT_SECRET || 'SECRET_KEY', // ¡Asegúrate de tener JWT_SECRET en .env!
      { expiresIn: '1h' }
    );

    res.json({
      token,
      usuario: {
        id: usuario.id,
        nombre: usuario.nombre,
        email: usuario.email,
        rol: usuario.rol,
      },
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.sendVerificationCode = async (req, res) => {
  try {
    const { email } = req.body;

    // Generar código de verificación
    const code = Math.floor(100000 + Math.random() * 900000).toString();

    // Guardar el código en la base de datos
    await VerificationCode.create({
      email,
      code,
      expiresAt: new Date(Date.now() + 15 * 60 * 1000), // 15 minutos
    });

    // Simular envío de correo electrónico
    console.log(`Código enviado al correo ${email}: ${code}`);

    res.json({ mensaje: 'Código enviado exitosamente' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.resetPassword = async (req, res) => {
  try {
    const { email, code, newPassword } = req.body;
    const verificationCode = await VerificationCode.findOne({ where: { email, code } });

    if (!verificationCode || verificationCode.expiresAt < new Date()) {
      return res.status(401).json({ error: 'Código inválido o expirado' });
    }

    // Hashear la nueva contraseña
    const hashedPassword = await bcrypt.hash(newPassword, 10);
    await Usuario.update(
      { contraseña: hashedPassword },
      { where: { email } }
    );

    // Eliminar el código usado
    await VerificationCode.destroy({ where: { id: verificationCode.id } });

    res.json({ mensaje: 'Contraseña actualizada' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};