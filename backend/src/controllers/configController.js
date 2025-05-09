const { Contenedor } = require('../models'); // Importar modelo

exports.actualizarUmbrales = async (req, res) => {
  try {
    const { umbral_critico, umbral_advertencia } = req.body;
    
    // Validar parámetros
    if (typeof umbral_critico !== 'number' || typeof umbral_advertencia !== 'number') {
      return res.status(400).json({ error: 'Los umbrales deben ser números' });
    }

    // Actualizar todos los contenedores (o crear una tabla de configuración global)
    await Contenedor.update(
      { umbral_critico, umbral_advertencia },
      { where: {} } // Aplica a todos los contenedores
    );

    res.json({ mensaje: 'Umbrales actualizados' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};