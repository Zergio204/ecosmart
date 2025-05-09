'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('ruta_contenedor', {
      id_ruta: {
        type: Sequelize.INTEGER,
        references: { model: 'rutas', key: 'id' }
      },
      id_contenedor: {
        type: Sequelize.INTEGER,
        references: { model: 'contenedores', key: 'id' }
      },
      estado: {
        type: Sequelize.ENUM('pendiente', 'recogido'),
        defaultValue: 'pendiente'
      },
      createdAt: Sequelize.DATE,
      updatedAt: Sequelize.DATE
    });
  },
  down: async (queryInterface) => {
    await queryInterface.dropTable('ruta_contenedor');
  }
};