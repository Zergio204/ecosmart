const Ruta = require('../models/Ruta');
const Contenedor = require('../models/Contenedor');
const { calcularRutaOptima } = require('../utils/mapboxUtils');

exports.crearRuta = async (req, res) => {
  try {
    const { id_operario, contenedores } = req.body;
    const ruta = await Ruta.create({ 
      id_operario,
      fecha: new Date(),
      distancia_km: 5.3 // Ejemplo, integrar con API de mapas
    });

    await ruta.addContenedores(contenedores);
    res.status(201).json({ mensaje: 'Ruta creada' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.listarRutas = async (req, res) => {
  try {
    const rutas = await Ruta.findAll({ 
      include: [Contenedor, { model: Usuario, as: 'operario' }]
    });
    res.json(rutas);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.crearRuta = async (req, res) => {
  try {
    const { id_operario, contenedorIds } = req.body;
    const contenedores = await Contenedor.findAll({ where: { id: contenedorIds } });
    
    const rutaOptima = await calcularRutaOptima(contenedores);
    const ruta = await Ruta.create({
      id_operario,
      distancia_km: rutaOptima.distance / 1000,
      duracion_min: rutaOptima.duration / 60,
      geometria: rutaOptima.geometry
    });

    await ruta.addContenedores(contenedores);
    res.status(201).json(ruta);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};