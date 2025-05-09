const Contenedor = require('./Contenedor');
const Ruta = require('./Ruta');

// Definir asociaciones después de importar ambos modelos
Contenedor.belongsToMany(Ruta, {
  through: 'ruta_contenedor',
  as: 'rutas',
  foreignKey: 'id_contenedor',
  otherKey: 'id_ruta',
  timestamps: false
});

Ruta.belongsToMany(Contenedor, {
  through: 'ruta_contenedor',
  foreignKey: 'id_ruta',
  as: 'contenedores',
  otherKey: 'id_contenedor',
  timestamps: false
});

module.exports = { Contenedor, Ruta };