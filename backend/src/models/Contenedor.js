const { DataTypes } = require('sequelize'); // Asegurar importación correcta
const sequelize = require('../config/dbConfig');

const Contenedor = sequelize.define('Contenedor', {
  ubicacion: { type: DataTypes.STRING, allowNull: false },
  capacidad_max: { type: DataTypes.INTEGER, allowNull: false },
  nivel_llenado: { type: DataTypes.INTEGER, defaultValue: 0 }
}, {
  tableName: 'contenedores', // Nombre de tabla explícito [[Primera Entrega.pdf]]
  timestamps: true
});

module.exports = Contenedor; // Exportar correctamente