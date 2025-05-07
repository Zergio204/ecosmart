const Emergencia = require('../models/Emergencia');
const { sendNotification } = require('../utils/notificationUtils');

exports.reportarEmergencia = async (req, res) => {
  try {
    const { id_contenedor, descripcion, imagen_url } = req.body;
    const emergencia = await Emergencia.create({
      id_contenedor,
      descripcion,
      imagen_url,
      estado: 'pendiente'
    });
    await sendNotification('EMERGENCIA_REPORTADA', { id_contenedor });
    res.status(201).json(emergencia);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.listarEmergencias = async (req, res) => {
  try {
    const emergencias = await Emergencia.findAll({ 
      include: Contenedor,
      where: { estado: 'pendiente' }
    });
    res.json(emergencias);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};