import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_bab/main.dart';
import 'package:intl/intl.dart';


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

Future<bool> setComment(String pid, Map<String, dynamic> comment) async {
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


Future<bool> setMatched(String? uid, String? oid, DateTime? date, TimeOfDay? time) async {
  //print("setMatch Start");
  uid = getUid(); /// 임시
  try {
    if(uid == null || oid == null || date == null || time == null){
      throw Exception("null catched");
    }
    Timestamp timestamp = Timestamp.fromDate(
      DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      ),
    );

    final data_u = {
      "otherid": oid,
      "timestamp": timestamp,
    };
    final data_o = {
      "otherid": uid,
      "timestamp": timestamp,
    };
    final UDoc = await db.collection("matched").doc(uid).get();
    if(!UDoc.exists) {
      db.collection("matched").doc(uid).set({});
    }
    final messageRef_u = db.collection("matched").doc(uid).collection("others").doc(oid);
    messageRef_u.set(data_u);

    final ODoc = await db.collection("matched").doc(oid).get();
    if(!ODoc.exists) {
      db.collection("matched").doc(oid).set({});
    }
    final messageRef_o = db.collection("matched").doc(oid).collection("others").doc(uid);
    messageRef_o.set(data_o);

    //print("true");

    return true;
  } catch (e) {
    //print(e);
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

Future<dynamic> getUserInfo(String fieldName, String uid) async {
  // Future<dynamic> getUserData(String fieldName) async : fieldName을 인자로 받아 현재 유저의 해당 field 데이터를 return함

  String doc = uid;
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

Future<List<Map<String, dynamic>>> getMatched() async {
  try {
    String uid = getUid();
    if (uid == "User not logged in.") {
      throw Exception("User not logged in.");
    }

    List<Map<String, dynamic>> documents = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db.collection("matched").doc(uid).collection("others").get();

    for (var docSnapshot in querySnapshot.docs) {
      final Map<String, dynamic> docMap = docSnapshot.data();
      final DocumentSnapshot<Map<String, dynamic>> otherUserSnapshot = await db.collection("users").doc(docMap['otherid']).get();
      if(!otherUserSnapshot.exists) throw Exception("other user data is null");
      final Map<String, dynamic> otherUserInfo = otherUserSnapshot.data()!;

      final String nickname = otherUserInfo["nickname"].toString();
      final String mannertemp = otherUserInfo["mannertemp"].toString();
      final String introduction = otherUserInfo["introduction"].toString();
      final List<String> interests = otherUserInfo["interests"].cast<String>();

      docMap['nickname'] = nickname;
      docMap['mannertemp'] = mannertemp;
      docMap['introduction'] = introduction;
      docMap['interests'] = interests;

      final DateTime dt = docMap['timestamp'].toDate().toLocal();
      final String dtstr = DateFormat('yyyy/MM/dd HH:mm:ss').format(dt);
      docMap['timestamp'] = dtstr;

      documents.add(docMap);
    }
    print(documents.toString());
    return documents;
  } catch (e) {
    print(e.toString());
    // 오류 처리 로직 추가
    return [];
  }
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

Future<bool> updateLike(String pid) async {
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

Future<bool> updateRate(String oid, double rating) async {
  String uid = getUid();
  if (uid == "User not logged in.") {
    throw Exception("User not logged in.");
  }

  final Map<String, dynamic> tmp = {
    "rating" : rating
  };
  await db.collection("matched").doc(uid).collection("others").doc(oid).update(tmp);
  return true;
}


