const webpush = require('web-push');

webpush.setVapidDetails(
  'mailto:admin@ecosmart.com',
  process.env.VAPID_PUBLIC_KEY,
  process.env.VAPID_PRIVATE_KEY
);

exports.sendNotification = async (tipo, datos) => {
  const subscriptores = await Subscriptor.findAll();
  subscriptores.forEach(sub => {
    webpush.sendNotification(sub.endpoint, JSON.stringify({
      tipo,
      datos
    }));
  });
};