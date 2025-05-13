const { Ruta, Contenedor } = require('../models');
const { calcularRutaOptima } = require('../utils/mapboxUtils');

exports.crearRuta = async (req, res) => {
  try {
    const { id_operario, contenedorIds, fecha, duracion_min } = req.body;

    // Validar campos obligatorios
    if (!id_operario || !contenedorIds || !fecha || !duracion_min) {
      return res.status(400).json({ error: 'Faltan campos obligatorios' });
    }

    // Buscar contenedores
    const contenedores = await Contenedor.findAll({
      where: { id: contenedorIds },
    });

    // Crear ruta
    const ruta = await Ruta.create({
      id_operario,
      fecha,
      duracion_min,
      distancia_km: 5.3, // Valor simulado
      estado: 'pendiente',
    });

    await ruta.addContenedores(contenedores);
    res.status(201).json(ruta);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.listarRutas = async (req, res) => {
  try {
    const rutas = await Ruta.findAll({
      include: [
        { 
          model: Contenedor, 
          as: 'contenedores',
          through: { attributes: [] } 
        }
      ]
    });
    res.json(rutas || []); // Devolver lista vacía si es null
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.getRuta = async (req, res) => {
  try {
    const ruta = await Ruta.findByPk(req.params.id, {
      include: ['contenedores'], // Incluir contenedores asociados
    });
    if (!ruta) {
      return res.status(404).json({ error: 'Ruta no encontrada' });
    }
    res.json(ruta);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.eliminarRuta = async (req, res) => {
  try {
    const ruta = await Ruta.findByPk(req.params.id);
    if (!ruta) {
      return res.status(404).json({ error: 'Ruta no encontrada' });
    }

    await ruta.destroy();
    res.json({ mensaje: 'Ruta eliminada' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};