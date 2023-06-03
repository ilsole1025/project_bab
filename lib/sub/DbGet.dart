import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_bab/main.dart';

/// SET

Future<bool> setPost(Map<String, dynamic> post) async {
  // Future<bool> setPost(Map<String, dynamic> post) async : post데이터를 db에 저장, 성공적으로 저장될 경우 true를 return함
  try {
    // 예외 처리가 들어갈 곳
    final DocId = db.collection("posts").doc();
    post["id"] = DocId.id;
    await DocId.set(post);
    return true;
  } catch (e) {
    ;
  }
  return false;
}

Future<bool> addComment(String pid, Map<String, dynamic> comment) async {
  try {
    int commentCount = 0;
    // 예외 처리가 들어갈 곳

    DocumentSnapshot<Map<String, dynamic>> snapshot = await db.collection("posts").doc(pid).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()!;
      if (data.containsKey("commentCount")) {
        commentCount = data["commentCount"];
      }
    }

    final Map<String, dynamic> post = {
      "commentCount" : commentCount+1,
    };
    await db.collection("posts").doc(pid).update(post);

    await db.collection("posts").doc(pid).collection("comments").doc(commentCount.toString()).set(comment);
    return true;
  } catch (e) {
    ;
  }
  return false;
}


Future<bool> setMatched(String uid, String oid, DateTime date, TimeOfDay time) async {
  try {
    final data_u = {
      "otherid": oid,
      "time": time,
      "date": date
    };
    final data_o = {
      "otherid": uid,
      "time": time,
      "date": date
    };
    await db.collection("matched").doc(uid).collection("others").doc(oid).set(data_u);
    await db.collection("matched").doc(oid).collection("others").doc(uid).set(data_o);
    return true;
  } catch (e) {
    return false;
  }
}


/// GET

String getUid() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user.uid;
  } else {
    return "User not logged in.";
  }
}

Future<Map<String, dynamic>> getUser() async{
  String doc = getUid();
  if (doc == "User not logged in.") {
    throw Exception("User not logged in.");
  }

  DocumentSnapshot<Map<String, dynamic>> snapshot = await db.collection("users").doc(doc).get();

  if (snapshot.exists) {
    Map<String, dynamic> userData = snapshot.data()!;
    return userData;
  } else {
    throw Exception("User data not found");
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

  return null; // 정보가 없는 경우
}

//Future<List<Map<String, dynamic>>>
Future<List<Map<String, dynamic>>> getMatched() async {
  List<Map<String, dynamic>> documents = [];

  try{
    String uid = getUid();
    if (uid == "User not logged in.") {
      throw Exception("User not logged in.");
    }

    await db.collection("matched").doc(uid).collection("others").get().then(
            (querySnapshot){
          for (var docSnapshot in querySnapshot.docs){
            documents.add(docSnapshot.data());
          }
        }
    );
  } catch (e) {
    ;
  }

  return documents;
}

Future<List<Map<String, dynamic>>> getPostList() async {
  // Future<List<Map<String, dynamic>>> getPostList() async : db에 존재하는 모든 post들을 List형태로 반환함
  QuerySnapshot<Map<String, dynamic>> snapshot = await db.collection("posts").orderBy("createdAt", descending: true).get();
  List<Map<String, dynamic>> postList = [];
  snapshot.docs.forEach((doc) {
    postList.add(doc.data());
  });
  return postList;
}

Future<List<Map<String, dynamic>>> getCommentList(String DocID) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await db.collection("posts").doc(DocID).collection("comments").get();
  List<Map<String, dynamic>> commentList = [];
  snapshot.docs.forEach((doc) {
    commentList.add(doc.data());
  });
  return commentList;
}


/// UPDATE

Future<bool> clickedLike(String pid) async {
  String uid = getUid();
  if (uid == "User not logged in.") {
    throw Exception("User not logged in.");
  }

  DocumentSnapshot<Map<String, dynamic>> snapshot = await db.collection("posts").doc(pid).get();
  if(snapshot.exists) {
    List<dynamic> likes = snapshot.data()!["likes"] ?? [];
    bool uidExists = likes.contains(uid);
    if(uidExists == true){
      likes.remove(uid);
      db.collection("posts").doc(pid).update({"likes": likes});
    } else {
      likes.add(uid);
      db.collection("posts").doc(pid).update({"likes": likes});
    }
    return !uidExists;
  } else {
    throw Exception("Document not exists");
  }
}


