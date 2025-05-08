const mqtt = require('mqtt');
const Contenedor = require('../models/Contenedor');

const client = mqtt.connect('mqtt://broker.hivemq.com');

client.on('connect', () => {
  console.log('Conectado al broker MQTT');
  setInterval(simularLlenado, 5000); // Llama a la función cada 5 segundos
});

const simularLlenado = async () => {
  try {
    const contenedores = await Contenedor.findAll();
    contenedores.forEach(async (contenedor) => {
      const nuevoNivel = Math.min(contenedor.nivel_llenado + Math.floor(Math.random() * 10), 100);
      await contenedor.update({ nivel_llenado: nuevoNivel });
      client.publish(`contenedor/${contenedor.id}`, JSON.stringify({ nivel: nuevoNivel }));
    });
  } catch (error) {
    console.error('Error en simulación:', error);
  }
};

module.exports = client;