const { DataTypes } = require('sequelize');
const sequelize = require('../config/dbConfig');
const Contenedor = require('./Contenedor'); // Ruta correcta al modelo

const Alerta = sequelize.define('Alerta', {
  umbral: { type: DataTypes.INTEGER, allowNull: false },
  fecha_hora: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },
  estado: { 
    type: DataTypes.ENUM('pendiente', 'resuelta'),
    defaultValue: 'pendiente'
  }
}, { timestamps: true });

// Corregir la asociación: usar el modelo Contenedor (no el nombre de la tabla)
Alerta.belongsTo(Contenedor, { foreignKey: 'id_contenedor' }); 
Contenedor.hasMany(Alerta, { foreignKey: 'id_contenedor' });

module.exports = Alerta;