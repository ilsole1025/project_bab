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
  this.mbti = -1;
  this.personality = -1;
  this.interest = [];
  this.sport = [];
  this.entertainment = [];
  this.career = [];
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
      //    save User Information
      await Promise.all(userArray.map(async (user) => {
        const docUser = await admin
            .firestore()
            .collection("users")
            .doc(user.uid)
            .get();
        const mbti = docUser.data().MBTI[0];

        if (mbti == "infp") {
          user.mbti = 0;
        } else if (mbti == "enfp") {
          user.mbti = 1;
        } else if (mbti == "infj") {
          user.mbti = 2;
        } else if (mbti == "enfj") {
          user.mbti = 3;
        } else if (mbti == "intj") {
          user.mbti = 4;
        } else if (mbti == "entj") {
          user.mbti = 5;
        } else if (mbti == "intp") {
          user.mbti = 6;
        } else if (mbti == "entp") {
          user.mbti = 7;
        } else if (mbti == "isfp") {
          user.mbti = 8;
        } else if (mbti == "esfp") {
          user.mbti = 9;
        } else if (mbti == "istp") {
          user.mbti = 10;
        } else if (mbti == "estp") {
          user.mbti = 11;
        } else if (mbti == "isfj") {
          user.mbti = 12;
        } else if (mbti == "esfj") {
          user.mbti = 13;
        } else if (mbti == "istj") {
          user.mbti = 14;
        } else if (mbti == "estj") {
          user.mbti = 15;
        }

        const personality = docUser.data().성격[0];
        if (personality == "내향적") {
          user.personality = 0;
        } else if (personality == "외향적") {
          user.personality = 1;
        } else if (personality == "이성적") {
          user.personality = 2;
        } else if (personality == "감성적") {
          user.personality = 3;
        } else if (personality == "낙천적") {
          user.personality = 4;
        }


        user.interest[0] = docUser.data().관심사[0];
        user.interest[1] = docUser.data().관심사[1];
        user.interest[2] = docUser.data().관심사[2];

        user.sport[0] = docUser.data().스포츠[0];
        user.sport[1] = docUser.data().스포츠[1];
        user.sport[2] = docUser.data().스포츠[2];

        user.entertainment.push(docUser.data().엔터테인먼트[0]);
        user.entertainment.push(docUser.data().엔터테인먼트[1]);
        user.entertainment.push(docUser.data().엔터테인먼트[2]);

        user.career.push(docUser.data().커리어[0]);
        user.career.push(docUser.data().커리어[1]);
        user.career.push(docUser.data().커리어[2]);

        const gender = docUser.data().gender;
        if (gender == "man") {
          user.gender = 0;
        } else {
          user.gender = 1;
        }

        const age = docUser.data().age;
        user.age = parseInt(age);

      },
      ));

      await Promise.all(userArray.map(async (user) => {

      }

      //    check code is working
      userArray.forEach((user) => {
        console.log("user: ", user.uid);
        console.log("mbti: ", user.mbti);
        console.log("gender: ", user.gender);
        console.log("age: ", user.age);
        console.log("personality: ", user.personality);
        console.log("sport: ", user.sport);
        console.log("interest: ", user.interest);
        console.log("career: ", user.career);
      });
      console.log("count: ", userCount);
      console.log(MBTI[0][0]);
    });

