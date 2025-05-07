const app = require('./src/app');
const sequelize = require('./src/config/dbConfig');

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
  sequelize.authenticate()
    .then(() => console.log('Base de datos conectada'))
    .catch(err => console.error('Error de conexión:', err));
});