'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('alertas', {
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
      umbral: {
        type: Sequelize.INTEGER,
        allowNull: false
      },
      fecha_hora: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.NOW
      },
      estado: {
        type: Sequelize.ENUM('pendiente', 'resuelta'),
        defaultValue: 'pendiente'
      },
      createdAt: Sequelize.DATE,
      updatedAt: Sequelize.DATE
    });
  },
  down: async (queryInterface) => {
    await queryInterface.dropTable('alertas');
  }
};