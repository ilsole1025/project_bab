import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_bab/sub/1st/make.dart';
import 'package:project_bab/sub/DbGet.dart';

var db = FirebaseFirestore.instance;

class matchingComplete extends StatelessWidget {
  const matchingComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
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
              print(currentFieldValue);
              return MakeDate();
            }
          }
          return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ));
        }
      ),
    );
  }
}
