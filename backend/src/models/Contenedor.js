const { DataTypes } = require('sequelize');
const sequelize = require('../config/dbConfig');

const Contenedor = sequelize.define('Contenedor', {
  ubicacion: { type: DataTypes.STRING, allowNull: false },
  capacidad_max: { type: DataTypes.INTEGER, allowNull: false },
  nivel_llenado: { 
    type: DataTypes.INTEGER, 
    defaultValue: 0,
    validate: { min: 0, max: 100 }
  }
}, { timestamps: true });

module.exports = Contenedor;