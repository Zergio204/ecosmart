const Contenedor = require('../models/Contenedor');

exports.listarContenedores = async (req, res) => {
  try {
    const contenedores = await Contenedor.findAll();
    res.json(contenedores);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.marcarRecogido = async (req, res) => {
  const contenedor = await Contenedor.findByPk(req.params.id);
  await contenedor.update({ nivel_llenado: 0 });
  res.json({ mensaje: 'Contenedor vaciado' });
};