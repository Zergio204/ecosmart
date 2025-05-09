const { DataTypes } = require('sequelize');
const sequelize = require('../config/dbConfig');
const Ruta = require('./Ruta');
const Contenedor = require('./Contenedor');

const RutaContenedor = sequelize.define('RutaContenedor', {
  estado: { 
    type: DataTypes.ENUM('pendiente', 'recogido'),
    defaultValue: 'pendiente'
  }
}, {
  tableName: 'ruta_contenedor', 
  timestamps: true
});

Ruta.belongsToMany(Contenedor, { through: RutaContenedor });
Contenedor.belongsToMany(Ruta, { through: RutaContenedor });
