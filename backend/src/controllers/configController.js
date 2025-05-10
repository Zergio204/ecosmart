const { Contenedor } = require('../models');

exports.actualizarUmbrales = async (req, res) => {
  try {
    const { umbral_critico, umbral_advertencia } = req.body;
    
    // Actualizar todos los contenedores
    await Contenedor.update(
      { umbral_critico, umbral_advertencia },
      { where: {} } // Aplica a todos
    );

    res.json({ mensaje: 'Umbrales actualizados' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.obtenerUmbrales = async (req, res) => {
  try {
    // Obtener umbrales del primer contenedor (asumiendo que todos tienen los mismos)
    const contenedor = await Contenedor.findOne({
      attributes: ['umbral_critico', 'umbral_advertencia']
    });
    
    if (!contenedor) {
      return res.status(404).json({ error: 'No hay contenedores registrados' });
    }

    res.json({
      umbral_critico: contenedor.umbral_critico,
      umbral_advertencia: contenedor.umbral_advertencia
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};