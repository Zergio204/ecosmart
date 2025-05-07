const { DataTypes } = require('sequelize');
const sequelize = require('../config/dbConfig');
const Contenedor = require('./Contenedor');

const Alerta = sequelize.define('Alerta', {
  umbral: { type: DataTypes.INTEGER, allowNull: false },
  fecha_hora: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
  estado: { 
    type: DataTypes.ENUM('pendiente', 'resuelta'), 
    defaultValue: 'pendiente' 
  }
}, { timestamps: true });

Alerta.belongsTo(Contenedor);
Contenedor.hasMany(Alerta);

module.exports = Alerta;