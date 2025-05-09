const Alerta = require('../models/Alerta');
const Contenedor = require('../models/Contenedor');

exports.verificarAlertas = async () => {
  const contenedores = await Contenedor.findAll();
  contenedores.forEach(async (contenedor) => {
    const alertaExistente = await Alerta.findOne({
      where: {
        id_contenedor: contenedor.id,
        estado: 'pendiente',
        umbral: contenedor.umbral_critico // Asegurar umbral dinámico
      }
    });

    if (!alertaExistente && contenedor.nivel_llenado >= contenedor.umbral_critico) {
      await Alerta.create({
        id_contenedor: contenedor.id,
        umbral: contenedor.umbral_critico,
        fecha_hora: new Date()
      });
    }
  });
};

exports.listarAlertas = async (req, res) => {
  try {
    const alertas = await Alerta.findAll({
      include: [{
        model: Contenedor,
        attributes: ['ubicacion'] // Añadir ubicación
      }]
    });
    res.json(alertas);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.marcarAlertaResuelta = async (req, res) => {
  try {
    const alerta = await Alerta.findByPk(req.params.id);
    if (!alerta) return res.status(404).json({ error: 'Alerta no encontrada' });
    
    await alerta.update({ estado: 'resuelta' });
    res.json({ mensaje: 'Alerta resuelta' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};