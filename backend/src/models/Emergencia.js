const { DataTypes } = require('sequelize');
const sequelize = require('../config/dbConfig');
const Contenedor = require('./Contenedor');

const Emergencia = sequelize.define('Emergencia', {
  descripcion: { type: DataTypes.TEXT, allowNull: false },
  imagen_url: { type: DataTypes.STRING, allowNull: true },
  estado: { 
    type: DataTypes.ENUM('pendiente', 'resuelta'),
    defaultValue: 'pendiente'
  }
}, {
  tableName: 'emergencias', 
  timestamps: true
});

Emergencia.belongsTo(Contenedor, { foreignKey: 'id_contenedor' });
Contenedor.hasMany(Emergencia, { foreignKey: 'id_contenedor' });

module.exports = Emergencia;