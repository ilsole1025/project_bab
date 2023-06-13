import 'dart:math';
import 'package:project_bab/main.dart';
import 'package:project_bab/sub/interest.dart';

createTestUser() async {
  Random random = Random();

  final age = (random.nextInt(10)+20).toString();
  final profileimg = random.nextInt(8)+1;
  Map<String, List<String>> interestMap =  {
    "MBTI" : [],
    "성격" : [],
    "관심사" : [],
    "엔터테인먼트" : [],
    "스포츠" : [],
    "커리어" : []
  };
  List<String> genderList = ["man","woman"];
  final String gender = genderList[random.nextInt(2)];

  try {
    for (String key in emptyInterest.keys) {
      int n = 0;
      if(maxSelectCountOfInterest[key]! == 1){
        n = 1;
      } else {
        n = random.nextInt(
            maxSelectCountOfInterest[key]! - minSelectCountOfInterest[key]!) +
            minSelectCountOfInterest[key]!;
      }
      List<String> randPool = List.from(INTEREST_VALUE[key]!);
      for (int i = 1; i <= n; i++) {
        randPool.shuffle();
        String val = randPool[0];
        interestMap[key]!.add(val);
        randPool.remove(val);
      }
    }
    List<String> interestList = interestMap.values.expand((values) => values).toList();

    String uid = "";
    await db.collection("users").add({}).then((docSnapshot) =>
    uid = docSnapshot.id);

    Map<String, dynamic> userData = {
      "age": age,
      "checked": true,
      "gender": gender,
      "introduction": "자기소개입니다",
      "kakaotalkid": "kakaoid",
      "mannertemp": 36.5,
      "matched": false,
      "matchingUser": "",
      "name": "테스트계정",
      "nickname": "테스트닉네임",
      "profileimg": profileimg,
      "uid": uid,
      "interests": interestList,
    };
    userData.addAll(interestMap);

    await db.collection("users").doc(uid).set(userData);
  } catch (e) {
    print(e.toString());
  }
}

createTestUsers(String userNum) async {
  try {
    int n = int.parse(userNum);
    if(n < 0 || n > 1000) throw Exception("userNum Invalid");
    for (int i = 1; i <= n; i++) {
      await createTestUser();
    }
  } catch (e) {
    print(e.toString());
  }
}

deleteTestUser() async {
  ;
}
