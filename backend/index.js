require('dotenv').config(); 
const app = require('./src/app'); // Importar la app Express
const sequelize = require('./src/config/dbConfig'); // Conexión a MySQL
const sensorClient = require('./src/utils/sensorSimulador');
const cron = require('node-cron'); // Para tareas programadas
const alertaController = require('./src/controllers/alertaController'); // Controlador de alertas

// Iniciar servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});

// Programar tareas
cron.schedule('*/10 * * * *', () => { 
  alertaController.verificarAlertas();
});

app.get('/api/suscribir-sensores', (req, res) => {
  res.writeHead(200, {
    'Content-Type': 'text/event-stream',
    'Cache-Control': 'no-cache',
    Connection: 'keep-alive'
  });

  sensorClient.on('connect', () => {
    console.log('Conectado al broker MQTT');
  });

});