import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_bab/sub/1st/make.dart';
import 'package:project_bab/sub/DbGet.dart';
import 'package:project_bab/sub/1st/matched.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:project_bab/sub/DbGet.dart';
import 'package:project_bab/widgets/app_large_text.dart';
import '../../widgets/app_text.dart';


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
              children: [
                Center(
                    child: SpinKitWanderingCubes(
                      color: Colors.red[300],
                      size: 250.0,
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppLargeText(text: "밥공친구를 매칭중입니다.\n"),
                    AppText(text: "약 1분 정도 소요되니 잠시만 기다려주세요.", color: Colors.blue),
                    SizedBox(height: 50,),
                    Container(
                        width: 200,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
                            backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFFEBEBEB"))),
                            foregroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFF000000"))),
                            shadowColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFFEBEBEB"))),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                          child: Text("랜덤 매칭 찾기 취소", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                          onPressed: () async{
                            final HttpsCallableResult result = await FirebaseFunctions
                                .instance
                                .httpsCallable("removeUserFromPool")
                                .call(<String, dynamic>{'uid': getUid()});


                            Navigator.pop(context);
                          },
                        )
                    ),
                  ],
                ),
              ]
            );
          }
      ),
    );
  }
}

