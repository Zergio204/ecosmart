const axios = require('axios');
const { Contenedor } = require('../models');

exports.generarPrediccion = async (req, res) => {
  try {
    const contenedor = await Contenedor.findByPk(req.params.id);
    if (!contenedor) return res.status(404).json({ error: 'Contenedor no encontrado' });

    // Simular predicción (reemplazar con modelo ML)
    const prediccion = [75, 82, 90]; // Niveles para próximos 3 días

    res.json({ prediccion });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.obtenerPrediccion = async (req, res) => {
  const prediccion = await Prediccion.findOne({
    where: { id_contenedor: req.params.id },
    order: [['fecha', 'DESC']]
  });
  res.json(prediccion);
};

exports.listarPredicciones = async (req, res) => {
  try {
    const contenedores = await Contenedor.findAll({
      attributes: { exclude: ['lat', 'lng'] } // ¡Excluir hasta migrar!
    });
    
    // Simular predicciones (reemplazar con ML)
    const predicciones = contenedores.map(contenedor => ({
      id_contenedor: contenedor.id,
      prediccion: [75, 82, 90] // Valores simulados
    }));

    res.json(predicciones);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};