const { sendNotification } = require('../utils/notificationUtils');
const { Emergencia, Contenedor } = require('../models');

exports.reportarEmergencia = async (req, res) => {
  try {
    const { id_contenedor, descripcion, imagen_url } = req.body;

    // Validar campos obligatorios
    if (!id_contenedor || !descripcion || !imagen_url) {
      return res.status(400).json({ error: 'Faltan campos obligatorios' });
    }

    // Crear la emergencia
    const nuevaEmergencia = await Emergencia.create({
      id_contenedor,
      descripcion,
      imagen_url,
    });

    res.status(201).json(nuevaEmergencia);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.listarEmergencias = async (req, res) => {
  try {
    const emergencias = await Emergencia.findAll({
      include: [Contenedor]
    });
    res.json(emergencias);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};