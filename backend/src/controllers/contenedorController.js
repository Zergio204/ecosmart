const Contenedor = require('../models/Contenedor');
const geolocationService = require('../services/geolocationService');

exports.crearContenedor = async (req, res) => {
  try {
    const { ubicacion, capacidad_max } = req.body;
    
    // Obtener coordenadas
    const { lat, lng } = await geolocationService.getCoordinates(ubicacion);
    
    const contenedor = await Contenedor.create({
      ubicacion,
      capacidad_max,
      lat,
      lng
    });
    
    res.status(201).json(contenedor);
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