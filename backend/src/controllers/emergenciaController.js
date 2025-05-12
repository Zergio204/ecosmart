const { sendNotification } = require('../utils/notificationUtils');
const { Emergencia, Contenedor } = require('../models');
const multer = require('multer');
const path = require('path');

exports.listarEmergencias = async (req, res) => {
  try {
    const emergencias = await Emergencia.findAll();
    res.json(emergencias || []); // Devolver lista vacía si no hay emergencias
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Configurar multer para almacenar imágenes
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, '/uploads/emergencias');
  },
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}-${file.originalname}`);
  },
});

const upload = multer({ storage });

exports.reportarEmergencia = [
  upload.single('imagen'), // Middleware para subir imagen
  async (req, res) => {
    try {
      const { id_contenedor, descripcion } = req.body;
      const imagenUrl = req.file ? req.file.path : null;

      // Validar campos obligatorios
      if (!id_contenedor || !descripcion || !imagenUrl) {
        return res.status(400).json({ error: 'Faltan campos obligatorios' });
      }

      // Crear la emergencia
      const emergencia = await Emergencia.create({
        id_contenedor,
        descripcion,
        imagen_url: imagenUrl,
      });

      res.status(201).json(emergencia);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
];