const { DataTypes } = require('sequelize');
const sequelize = require('../config/dbConfig');

const Emergencia = sequelize.define('Emergencia', {
  id_contenedor: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: 'contenedores',
      key: 'id'
    }
  },
  descripcion: {
    type: DataTypes.STRING,
    allowNull: false
  },
  imagen_url: {
    type: DataTypes.STRING,
    allowNull: false
  }
}, {
  tableName: 'emergencias',
  timestamps: true
});

module.exports = Emergencia;