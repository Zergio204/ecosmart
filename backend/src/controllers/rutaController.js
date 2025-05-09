const { Ruta, Contenedor } = require('../models'); // Importar desde index.js
const { calcularRutaOptima } = require('../utils/mapboxUtils');

exports.crearRuta = async (req, res) => {
  try {
    const { id_operario, contenedorIds } = req.body;
    
    // Buscar contenedores (sin lat/lng)
    const contenedores = await Contenedor.findAll({ 
      where: { id: contenedorIds },
      attributes: ['id', 'ubicacion', 'capacidad_max'] // ¡Excluir lat/lng!
    });

    // Crear ruta
    const ruta = await Ruta.create({
      id_operario,
      fecha: new Date(),
      distancia_km: 5.3,
      duracion_min: 45,
      estado: 'pendiente'
    });

    // Asociar contenedores (¡con el alias correcto!)
    await ruta.addContenedores(contenedores); // ¡Corregir aquí!

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
          as: 'contenedores', // ¡Alias definido en Contenedor.js!
          through: { attributes: [] } 
        }
      ]
    });
    res.json(rutas);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};