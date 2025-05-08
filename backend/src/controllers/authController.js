const Usuario = require('../models/Usuario');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

exports.registro = async (req, res) => {
  try {
    const hashedPassword = await bcrypt.hash(req.body.contraseña, 10);
    const usuario = await Usuario.create({ 
      ...req.body, 
      contraseña: hashedPassword 
    });
    res.status(201).json({ mensaje: 'Usuario creado' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.login = async (req, res) => {
  try {
    const usuario = await Usuario.findOne({ where: { email: req.body.email } });
    if (!usuario) return res.status(404).json({ error: 'Usuario no encontrado' });
    
    const match = await bcrypt.compare(req.body.contraseña, usuario.contraseña);
    if (!match) return res.status(401).json({ error: 'Contraseña incorrecta' });
    
    const token = jwt.sign({ id: usuario.id }, process.env.JWT_SECRET, { expiresIn: '1h' });
    res.json({ token, rol: usuario.rol });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};