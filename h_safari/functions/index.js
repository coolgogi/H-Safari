const functions = require('firebase-functions');
const admin = require("firebase-admin");

admin.initializeApp();
//send FCM = 실제 FCM를 보내는 함수
exports.sendFCM = functions.https.onCall((data, context) => {
  var token = data["token"];
  var title = data["title"];
  var body = data["body"];

  var payload = {
    notification: {
      title: title,
      body: body
    }
  }

  var result = admin.messaging().sendToDevice(token, payload);
  return result;
})