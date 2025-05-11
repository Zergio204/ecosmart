// src/emailService.js
const nodemailer = require('nodemailer');

class EmailService {
  async sendVerificationCode(email, code) {
    // Configurar el transportador de Gmail
    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASSWORD,
      },
    });

    // Enviar el correo electrónico
    await transporter.sendMail({
      from: process.env.EMAIL_USER,
      to: email,
      subject: 'Código de Verificación',
      text: `Tu código de verificación es: ${code}`,
    });
  }
}

module.exports = new EmailService();