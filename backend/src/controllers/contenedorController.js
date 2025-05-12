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

exports.marcarRecogido = async (req, res) => {
  const contenedor = await Contenedor.findByPk(req.params.id);
  await contenedor.update({ nivel_llenado: 0 });
  res.json({ mensaje: 'Contenedor vaciado' });
};

exports.actualizarContenedor = async (req, res) => {
  try {
    const { id } = req.params;
    const { ubicacion, capacidad_max } = req.body;

    // Excluir lat/lng temporalmente
    const contenedor = await Contenedor.findByPk(id, {
      attributes: { exclude: ['lat', 'lng'] }
    });
    if (!contenedor) return res.status(404).json({ error: 'Contenedor no encontrado' });

    await contenedor.update({ ubicacion, capacidad_max });
    res.json({ mensaje: 'Contenedor actualizado' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.eliminarContenedor = async (req, res) => {
  try {
    const contenedor = await Contenedor.findByPk(req.params.id);
    if (!contenedor) return res.status(404).json({ error: 'Contenedor no encontrado' });

    await contenedor.destroy();
    res.json({ mensaje: 'Contenedor eliminado' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.detalleContenedor = async (req, res) => {
  try {
    const contenedor = await Contenedor.findByPk(req.params.id);
    if (!contenedor) return res.status(404).json({ error: 'Contenedor no encontrado' });
    res.json(contenedor);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.listarContenedores = async (req, res) => {
  try {
    const contenedores = await Contenedor.findAll({
      attributes: ['id', 'ubicacion', 'capacidad_max', 'nivel_llenado', 'lat', 'lng', 'umbral_critico']
    });
    res.json(contenedores);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};