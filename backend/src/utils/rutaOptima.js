const axios = require('axios');

exports.calcularRutaOptima = async (contenedores) => {
  const coordenadas = contenedores.map(c => c.ubicacion);
  const response = await axios.get('https://api.mapbox.com/directions/v5/mapbox/driving', {
    params: {
      coordinates: coordenadas.join(';'),
      access_token: process.env.MAPBOX_TOKEN
    }
  });
  return response.data.routes[0];
};