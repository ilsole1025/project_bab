import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_bab/sub/1st/make.dart';
import 'package:project_bab/sub/DbGet.dart';
import 'package:project_bab/sub/1st/matched.dart';

var db = FirebaseFirestore.instance;

Future<void> updateDocumentField(String collection, String documentId, String fieldName, dynamic value) async {
  final collectionRef = db.collection(collection);
  await collectionRef.doc(documentId).update({ fieldName: value });
}

Future<dynamic> getDocumentField(String collection, String documentId, String fieldName) async {
  final documentSnapshot = await FirebaseFirestore.instance.collection(collection).doc(documentId).get();
  final data = documentSnapshot.data();
  if (data != null && data.containsKey(fieldName)) {
    return data[fieldName];
  }
  return null;
}

class matchingComplete extends StatelessWidget {
  const matchingComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    updateDocumentField("users", getUid(), "matchingUser", "");
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot> (
          stream: db.collection("users").doc(getUid()).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ));
            } else {
              var documentData = snapshot.data!.data() as Map<String, dynamic>;
              var currentFieldValue = documentData['matchingUser'];
              if(currentFieldValue != "") {
                var myuid = documentData['uid'].toString();
                var mynickname = documentData['nickname'];
                var mytemp = documentData['mannertemp'];
                var myintro = documentData['introduction'];
                var mykakao = documentData['kakaotalkid'];
                var myinterest = documentData['관심사'];

                setMatched(myuid, currentFieldValue, DateTime.now(), TimeOfDay.now());

                return Matched(
                  myUid: myuid,
                  otherUid: currentFieldValue,
                  my_info: {
                    "name": mynickname,
                    "temperature": mytemp,
                    "introduction": myintro,
                    "image": "111.jpeg",
                    "kakao": mykakao,
                    "interest" : myinterest,
                  },
                );

              }
            }
            return Stack (
              fit: StackFit.expand,
              children: const [
                Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 10,
                      backgroundColor: Colors.lightBlueAccent,
                    )),
                Center(
                  child: Text(
                    "현재 매칭 중입니다. 1~2분 소요되니 기다려주세요",
                    style: TextStyle(fontSize: 20),
                  )
                )
              ]
            );
          }
      ),
    );
  }
}

