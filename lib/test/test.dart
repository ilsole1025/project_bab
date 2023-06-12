import 'package:flutter/material.dart';
import 'package:project_bab/sub/DbGet.dart';
import 'dart:math';

void createTestUser() async {
  Random random = Random();

  final age = (random.nextInt(10)+20).toString();
  final profileimg = random.nextInt(8)+1;
  Map<String, dynamic> userData = {
    "age" : age,
    "checked" : true,
    "gender" : "woman",
    "introduction" : "자기소개입니다",
    "kakaotalkid" : "kakaolid",
    "mannertemp" : 36.5,
    "matched" : false,
    "matchingUser" : "",
    "name" : "테스트",
    "nickname" : "닉네임",
    "profileimg" : profileimg,
    "uid" : "uid필요"
  };
}

void deleteTestUser() async {
  ;
}
