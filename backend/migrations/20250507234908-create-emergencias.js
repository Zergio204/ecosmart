'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('emergencias', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      id_contenedor: {
        type: Sequelize.INTEGER,
        references: {
          model: 'contenedores',
          key: 'id'
        }
      },
      descripcion: {
        type: Sequelize.TEXT,
        allowNull: false
      },
      imagen_url: Sequelize.STRING,
      estado: {
        type: Sequelize.ENUM('pendiente', 'resuelta'),
        defaultValue: 'pendiente'
      },
      createdAt: Sequelize.DATE,
      updatedAt: Sequelize.DATE
    });
  },
  down: async (queryInterface) => {
    await queryInterface.dropTable('emergencias');
  }
};