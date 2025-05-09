module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.addColumn('contenedores', 'lat', {
      type: Sequelize.FLOAT,
      allowNull: true
    });
    await queryInterface.addColumn('contenedores', 'lng', {
      type: Sequelize.FLOAT,
      allowNull: true
    });
  },
  down: async (queryInterface) => {
    await queryInterface.removeColumn('contenedores', 'lat');
    await queryInterface.removeColumn('contenedores', 'lng');
  }
};