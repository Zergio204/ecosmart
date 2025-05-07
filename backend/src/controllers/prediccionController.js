const axios = require('axios');

exports.generarPrediccion = async (req, res) => {
  try {
    const contenedor = await Contenedor.findByPk(req.params.id);
    const historial = await contenedor.getHistorial(); // Implementar en modelo

    const response = await axios.post('http://ml-service:5000/predict', {
      historial: historial.map(h => ({ dia: h.fecha, nivel: h.nivel }))
    });

    res.json({ prediccion: response.data.prediccion });
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