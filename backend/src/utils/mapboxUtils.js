const axios = require('axios');

exports.calcularRutaOptima = async (contenedores) => {
  const coordenadas = contenedores.map(c => 
    c.ubicacion.split(',').reverse().join(',')
  ).join(';');

  const response = await axios.get(
    `https://api.mapbox.com/directions/v5/mapbox/driving/${coordenadas}`,
    {
      params: {
        access_token: process.env.MAPBOX_TOKEN,
        geometries: 'geojson',
        overview: 'full'
      }
    }
  );

  return response.data.routes[0];
};