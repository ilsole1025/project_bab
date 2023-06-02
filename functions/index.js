/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(); // Firebase Admin SDK 초기화

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

exports.helloWorld = onRequest((request, response) => {
  response.send({data: "hello world!"});
});

exports.addUserToPool = functions.https.onCall((data, context) => {
  const uid = data["uid"];
  admin
      .firestore()
      .collection("matchingPool")
      .doc("users")
      .set(
          {userpool: admin.firestore.FieldValue.arrayUnion(uid)},
          {merge: true},
      );
  return;
});

exports.removeUserFromPool = functions.https.onCall((data, context) => {
  const uid = data["uid"];
  const target = admin.firestore().collection("matchingPool").doc("users");
  target.update({
    userpool: admin.firestore.FieldValue.arrayRemove(uid),
  });

  return;
});

