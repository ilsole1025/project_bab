
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_bab/main.dart';


String getUid() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user.uid;
  } else {
    return "User not logged in.";
  }
}

Future<dynamic> getUserData(String fieldName) async {
  // Future<dynamic> getUserData(String fieldName) async : fieldName을 인자로 받아 현재 유저의 해당 field 데이터를 return함

  String doc = getUid();
  if (doc == "User not logged in.") {
    throw Exception("User not logged in.");
  }

  DocumentSnapshot<Map<String, dynamic>> snapshot = await db.collection("users").doc(doc).get();

  if (snapshot.exists) {
    Map<String, dynamic> data = snapshot.data()!;
    if (data.containsKey(fieldName)) {
      return data[fieldName];
    }
  }
  return "닉네임"; // nickname 정보가 없는 경우
}

Future<bool> setPost(Map<String, dynamic> post) async {
  // Future<bool> setPost(Map<String, dynamic> post) async : post데이터를 db에 저장, 성공적으로 저장될 경우 true를 return함
  try {
    // 예외 처리가 들어갈 곳

    await db.collection("posts").add(post);
    return true;
  } catch (e) {
    ;
  }
  return false;
}

Future<List<Map<String, dynamic>>> getPostList() async {
  // Future<List<Map<String, dynamic>>> getPostList() async : db에 존재하는 모든 post들을 List형태로 반환함
  QuerySnapshot<Map<String, dynamic>> snapshot = await db.collection("posts").get();
  List<Map<String, dynamic>> postList = [];
  snapshot.docs.forEach((doc) {
    postList.add(doc.data());
  });
  return postList;
}

delPost() async {
  ;
}