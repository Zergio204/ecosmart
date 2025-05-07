const express = require('express');
const sequelize = require('./config/dbConfig');
const authRoutes = require('./routes/authRoutes');
const contenedorRoutes = require('./routes/contenedorRoutes');
const cron = require('node-cron');
const alertaController = require('./controllers/alertaController');
const sensorClient = require('./utils/sensorSimulador');
const emergenciaRoutes = require('./routes/emergenciaRoutes');

const app = express();

app.use(express.json());

// Rutas
app.use('/api', authRoutes);
app.use('/api/contenedores', contenedorRoutes);

// Conexión a la base de datos
sequelize.sync()
  .then(() => console.log('Base de datos conectada'))
  .catch(err => console.error('Error de conexión:', err));

module.exports = app;

// Verificar alertas cada 10 minutos
cron.schedule('*/10 * * * *', () => {
  alertaController.verificarAlertas();
});

// WebSocket para actualización en tiempo real
app.get('/api/suscribir-sensores', (req, res) => {
  res.writeHead(200, {
    'Content-Type': 'text/event-stream',
    'Cache-Control': 'no-cache',
    Connection: 'keep-alive'
  });

  sensorClient.on('message', (topic, message) => {
    res.write(`data: ${message}\n\n`);
  });
});

// Nuevas rutas
app.use('/api', emergenciaRoutes);

// WebSocket para notificaciones
app.get('/api/suscribir-notificaciones', (req, res) => {
  res.writeHead(200, {
    'Content-Type': 'text/event-stream',
    'Cache-Control': 'no-cache',
    Connection: 'keep-alive'
  });

  req.on('close', () => {
    console.log('Cliente desconectado');
  });
});