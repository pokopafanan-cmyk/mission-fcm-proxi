const admin = require('firebase-admin');

// 1. Connexion à Firebase grâce à ta clé secrète
const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

// 2. TON TOKEN FCM UNIQUE QU'ON A RÉCUPÉRÉ TOUT À L'HEURE
const registrationToken = 'eqoVadKJQWKUkVrD8I-CBd:APA91bEKtWmMqmVr0Ci9mnmKwP5RadI6lYDQIh7py8Ji1o32921ZdVrS5YcON_ESniT-Cw1zAMPmdzVPAfBMKjYC2dXrUbpAdV_dIS1xFGhMj9DOwS446p8';

// 3. Configuration de la notification avec les données requises pour ton écran de détail
const message = {
  notification: {
    title: 'Mission FCM Réussie ',
    body: ' notification push personnalisée fonctionne parfaitement.'
  },
  data: {
    projet: 'Proxi',
    statut: 'Validé',
    developpeur: 'Zalissa Zongo',
    date: new Date().toLocaleString('fr-FR')
  },
  token: registrationToken
};

// 4. Envoi du message via Firebase
admin.messaging().send(message)
  .then((response) => {
    console.log('✅ Notification envoyée avec succès !');
    console.log('ID du message Firebase :', response);
  })
  .catch((error) => {
    console.error(' Erreur lors de l\'envoi :', error);
  });