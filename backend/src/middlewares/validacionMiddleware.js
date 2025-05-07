const { body, validationResult } = require('express-validator');

exports.validarRegistro = [
  body('nombre').notEmpty().withMessage('El nombre es requerido'),
  body('email').isEmail().withMessage('Email inválido'),
  body('contraseña').isLength({ min: 6 }).withMessage('Mínimo 6 caracteres')
];

exports.validarResultados = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errores: errors.array() });
  }
  next();
};