const { DataTypes } = require('sequelize'); // Asegurar importación correcta
const sequelize = require('../config/dbConfig');
const Ruta = require('./Ruta');

const Contenedor = sequelize.define('Contenedor', {
  ubicacion: { type: DataTypes.STRING, allowNull: false },
  capacidad_max: { type: DataTypes.INTEGER, allowNull: false },
  nivel_llenado: { type: DataTypes.INTEGER, defaultValue: 0 },
  lat: { type: DataTypes.FLOAT }, // Añadido
  lng: { type: DataTypes.FLOAT }, // Añadido
  umbral_critico: { type: DataTypes.INTEGER, defaultValue: 80 }
},{
  tableName: 'contenedores', // Nombre de tabla explícito
  timestamps: true
});

module.exports = Contenedor; // Exportar correctamente
