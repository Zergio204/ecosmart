const { DataTypes } = require('sequelize');
const sequelize = require('../config/dbConfig');
const Usuario = require('./Usuario');
const Contenedor = require('./Contenedor');

const Ruta = sequelize.define('Ruta', {
  fecha: { type: DataTypes.DATE, allowNull: false },
  estado: { 
    type: DataTypes.ENUM('pendiente', 'en_curso', 'completada'),
    defaultValue: 'pendiente'
  },
  distancia_km: { type: DataTypes.FLOAT, defaultValue: 0 },
  duracion_min: { type: DataTypes.INTEGER, defaultValue: 0 }
}, {
  tableName: 'rutas', 
  timestamps: true
});

module.exports = Ruta;