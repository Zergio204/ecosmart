const Contenedor = require('../models/Contenedor');

exports.crearContenedor = async (req, res) => {
  try {
    const contenedor = await Contenedor.create(req.body);
    res.status(201).json(contenedor); // Respuesta correcta
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

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