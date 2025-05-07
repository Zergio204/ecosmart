const { DataTypes } = require('sequelize');
const sequelize = require('../config/dbConfig');

const Usuario = sequelize.define('Usuario', {
  nombre: { type: DataTypes.STRING, allowNull: false },
  email: { type: DataTypes.STRING, unique: true, allowNull: false },
  contraseña: { type: DataTypes.STRING, allowNull: false },
  rol: { 
    type: DataTypes.ENUM('admin', 'operario', 'ciudadano'), 
    defaultValue: 'ciudadano' 
  }
}, { timestamps: true });

module.exports = Usuario;