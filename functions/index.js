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

// my data
const MBTI = [
  [3, 3, 3, 4, 3, 4, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0],
  [3, 3, 4, 3, 4, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0],
  [3, 4, 3, 3, 3, 3, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0],
  [4, 3, 3, 3, 3, 3, 3, 3, 4, 0, 0, 0, 0, 0, 0, 0],
  [3, 4, 3, 3, 3, 3, 3, 4, 2, 2, 2, 2, 1, 1, 1, 1],
  [4, 3, 3, 3, 3, 3, 4, 3, 2, 2, 2, 2, 2, 2, 2, 2],
  [3, 3, 3, 3, 3, 4, 3, 3, 2, 2, 2, 2, 1, 1, 1, 4],
  [3, 3, 4, 3, 4, 3, 3, 3, 2, 2, 2, 2, 1, 1, 1, 1],
  [0, 0, 0, 4, 2, 2, 2, 2, 1, 1, 1, 1, 2, 4, 2, 4],
  [0, 0, 0, 0, 2, 2, 2, 2, 1, 1, 1, 1, 2, 4, 2, 4],
  [0, 0, 0, 0, 2, 2, 2, 2, 1, 1, 1, 1, 2, 4, 2, 4],
  [0, 0, 0, 0, 2, 2, 2, 2, 1, 1, 1, 1, 2, 4, 2, 4],
  [0, 0, 0, 0, 1, 2, 1, 1, 2, 4, 2, 4, 3, 3, 3, 3],
  [0, 0, 0, 0, 1, 2, 1, 1, 2, 4, 2, 4, 3, 3, 3, 3],
  [0, 0, 0, 0, 1, 2, 1, 1, 2, 4, 2, 4, 3, 3, 3, 3],
  [0, 0, 0, 0, 1, 2, 4, 1, 2, 4, 2, 4, 3, 3, 3, 3],
];

/**
 * @param {uid} uid The first number.
 */
function Person(uid) {
  this.uid = uid;
  this.gender = -1;
  this.mbti = "";
  this.personality = -1;
}

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

exports.matchingAlgorythm = functions.pubsub.schedule("* * * * *")
    .timeZone("Asia/Seoul") // Users can choose timezone - default is UTC
    .onRun(async (context) => {
      const userArray = [];
      let userCount = 0;
      console.log("Matching algorythm executed!");
      const ref = admin.firestore()
          .collection("matchingPool")
          .doc("users");
      const doc = await ref.get();
      if (!doc.exists) {
        console.log("no such document");
      } else {
        const userpool = doc.data().userpool;
        for (const user of userpool) {
          const person = new Person(user);
          userArray.push(person);
          userCount += 1;
        }
      }
      //    calculate MBTI
      await Promise.all(userArray.map(async (user) => {
        const docUser = await admin
            .firestore()
            .collection("users")
            .doc(user.uid)
            .get();
        const mbti = docUser.data().MBTI[0];
        console.log("Check MBTI:", mbti);
        user.mbti = mbti;
      }));

      //    check code is working
      userArray.forEach((user) => {
        console.log("user: ", user.uid);
        console.log("mbti: ", user.mbti);
      });
      console.log("count: ", userCount);
      console.log(MBTI[0][0]);
    });

