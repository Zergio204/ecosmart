const express = require('express');
const sequelize = require('./config/dbConfig');
const cron = require('node-cron');
const cors = require('cors');
const authRoutes = require('./routes/authRoutes');
const contenedorRoutes = require('./routes/contenedorRoutes');
const alertaRoutes = require('./routes/alertaRoutes');
const emergenciaRoutes = require('./routes/emergenciaRoutes');
const rutaRoutes = require('./routes/rutaRoutes');
const sensorClient = require('./utils/sensorSimulador');

const app = express();

// Middleware
app.use(cors()); // Habilitar CORS para Flutter [[3]]
app.use(express.json()); // Parsear JSON [[4]]
require('dotenv').config();

// Rutas (todas bajo /api)
app.use('/api', authRoutes);
app.use('/api/contenedores', contenedorRoutes);
app.use('/api/alertas', alertaRoutes);
app.use('/api/emergencias', emergenciaRoutes);
app.use('/api/rutas', rutaRoutes);

// WebSocket para sensores (SSE)
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

// WebSocket para notificaciones (SSE)
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

// Sincronización con la base de datos
sequelize.sync()
  .then(() => console.log('Base de datos conectada'))
  .catch(err => console.error('Error de conexión:', err));

// Cron job para verificar alertas (cada 10 minutos)
cron.schedule('*/10 * * * *', () => {
  require('./controllers/alertaController').verificarAlertas(); // [[Primera Entrega.pdf]]
});

// Puerto de escucha
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});

module.exports = app;