'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('contenedores', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      ubicacion: {
        type: Sequelize.STRING,
        allowNull: false
      },
      capacidad_max: {
        type: Sequelize.INTEGER,
        allowNull: false
      },
      nivel_llenado: {
        type: Sequelize.INTEGER,
        defaultValue: 0
      },
      ultima_actualizacion: Sequelize.DATE,
      createdAt: Sequelize.DATE,
      updatedAt: Sequelize.DATE
    });
  },
  down: async (queryInterface) => {
    await queryInterface.dropTable('contenedores');
  }
};