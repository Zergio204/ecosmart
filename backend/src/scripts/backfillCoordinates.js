const Contenedor = require('../src/models/Contenedor');
const geolocationService = require('../src/services/geolocationService');

(async () => {
  const contenedores = await Contenedor.findAll();
  for (const contenedor of contenedores) {
    const { lat, lng } = await geolocationService.getCoordinates(contenedor.ubicacion);
    await contenedor.update({ lat, lng });
  }
})();