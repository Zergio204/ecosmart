const { DataTypes } = require('sequelize');
const sequelize = require('../config/dbConfig');
const Usuario = require('./Usuario');

const Ruta = sequelize.define('Ruta', {
  fecha: { type: DataTypes.DATE, allowNull: false },
  estado: { 
    type: DataTypes.ENUM('pendiente', 'en_curso', 'completada'),
    defaultValue: 'pendiente'
  },
  distancia_km: { type: DataTypes.FLOAT, defaultValue: 0 },
  duracion_min: { type: DataTypes.INTEGER, defaultValue: 0 }
}, { timestamps: true });

Ruta.belongsTo(Usuario, { as: 'operario', foreignKey: 'id_operario' });
Usuario.hasMany(Ruta, { foreignKey: 'id_operario' });

module.exports = Ruta;