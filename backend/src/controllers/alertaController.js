const Alerta = require('../models/Alerta');
const Contenedor = require('../models/Contenedor');

exports.verificarAlertas = async () => {
  const contenedores = await Contenedor.findAll();
  contenedores.forEach(async (contenedor) => {
    if (contenedor.nivel_llenado >= 80) { // Umbral crítico
      await Alerta.create({
        id_contenedor: contenedor.id,
        umbral: 80,
        estado: 'pendiente'
      });
    }
  });
};

exports.listarAlertas = async (req, res) => {
  try {
    const alertas = await Alerta.findAll({ include: Contenedor });
    res.json(alertas);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.marcarAlertaResuelta = async (req, res) => {
  try {
    const alerta = await Alerta.findByPk(req.params.id);
    alerta.estado = 'resuelta';
    await alerta.save();
    res.json({ mensaje: 'Alerta resuelta' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};