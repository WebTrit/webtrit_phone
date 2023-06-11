importScripts("https://www.gstatic.com/firebasejs/9.22.2/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.22.2/firebase-messaging-compat.js");

// Copy form `web` static const in `lib/firebase_options.dart`
firebase.initializeApp({
  apiKey: 'AIzaSyDdWVaDGe0mPRkngXQEUsS1_EQiFyXdoxE',
  appId: '1:524910534863:web:8ee29ada8594349e4ad7ba',
  messagingSenderId: '524910534863',
  projectId: 'webtrit-69559',
  authDomain: 'webtrit-69559.firebaseapp.com',
  storageBucket: 'webtrit-69559.appspot.com',
  measurementId: 'G-2EWYFX6650',
});

// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});
