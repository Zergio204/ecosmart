const axios = require('axios');

exports.getCoordinates = async (address) => {
  try {
    const response = await axios.get(
      'https://api.mapbox.com/geocoding/v5/mapbox.places/' + 
      encodeURIComponent(address) + '.json',
      {
        params: {
          access_token: process.env.MAPBOX_TOKEN,
          limit: 1
        }
      }
    );
    
    const [lng, lat] = response.data.features[0].center;
    return { lat, lng };
  } catch (error) {
    throw new Error('Error al geocodificar dirección');
  }
};