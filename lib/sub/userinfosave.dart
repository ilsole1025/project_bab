
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_bab/main.dart';
import 'exception.dart';



class UserInfoSave extends StatefulWidget {
  const UserInfoSave({Key? key}) : super(key: key);

  @override
  State<UserInfoSave> createState() => _UserInfoSaveState();
}

class _UserInfoSaveState extends State<UserInfoSave> {
  final List<String> _ageList = ['선택하기','20','21','22','23','24','25','26','27','28','29','30'];
  final List<String> _mbtiList = ['선택하기','infp','infj','intp','intj','isfp','isfj','istp','istj','enfp','enfj','entp','entj','esfp','esfj','estp','estj'];
  TextEditingController nicknamecontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  String _gender = '', _age = '선택하기', _mbti = '선택하기';

  bool showSpinner = false;

  Future<bool> _checkNickname(String nickname) async {
    final querySnapshot = await db.collection('users').where('nickname', isEqualTo: nickname).get();
    return querySnapshot.docs.isNotEmpty;
  }

  _userInfoSaveInFireStore() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    final user = <String, dynamic>{
      "nickname": nicknamecontroller.text,
      "name" : namecontroller.text,
      "gender": _gender,
      "age": _age,
      "mbti": _mbti,
      "checked": true,
    };
    if (currentUser != null) {
      try {
        // 닉네임
        if(nicknamecontroller.text == ''){
          throw myException('no-nickname'); // 닉네임 입력 안했을 때
        } else if(nicknamecontroller.text.length < 2 || nicknamecontroller.text.length > 10){
          throw myException('exceed-nickname'); // 닉네임 2~10글자 사이로 제한(임시)
        } else if(nicknamecontroller.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
          throw myException('special-nickname'); // 닉네임에 특수 문자가 포함될 때
        }
        bool isDuplicated = await _checkNickname(nicknamecontroller.text);
        if(isDuplicated == true) {
          throw myException('duplicated-nickname'); // 닉네임 중복 확인
        }
        // 이름 입력 안했을 때
        if(namecontroller.text == '선택하기'){
          throw myException('no-name');
        } else if(namecontroller.text.length > 20){
          throw myException('exceed-name'); // 이름 ~20글자 로 제한(임시)
        } else if(namecontroller.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
          throw myException('special-name'); // 이름에 특수 문자가 포함될 때
        }
        // 성별 입력 안했을 때
        if(_gender == ''){
          throw myException('no-gender');
        }
        // 나이 입력 안했을 때
        if(_age == '선택하기'){
          throw myException('no-age');
        }
        // mbti 입력 안했을 때
        if(_mbti == '선택하기'){
          throw myException('no-mbti');
        }
        db.collection("users").doc("${currentUser.uid}").set(user);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>
            MyHomePage(title: "밥먹공"))
        );
        showSpinner = false;
      } on myException catch (e) {
        String message = '';
        if (e.toString() == 'no-nickname') {
          message = "닉네임을 입력해주세요";
        } else if(e.toString() == 'exceed-nickname') {
          message = "닉네임은 2글자에서 10글자 사이여야 합니다";
        } else if(e.toString() == 'special-nickname') {
          message = "닉네임에 특수문자를 사용할 수 없습니다";
        } else if(e.toString() == 'duplicated-nickname') {
          message = "중복된 닉네임입니다";
        } else if(e.toString() == 'no-name') {
          message = "이름을 입력해주세요";
        } else if(e.toString() == 'exceed-name') {
          message = "이름이 너무 깁니다";
        } else if(e.toString() == 'special-name') {
          message = "이름에 특수문자가 포함되어 있습니다";
        } else if(e.toString() == 'no-gender') {
          message = "성별을 선택해주세요";
        } else if(e.toString() == 'no-age') {
          message = "나이를 선택해주세요";
        } else if(e.toString() == 'no-mbti') {
          message = "mbti를 선택해주세요";
        }
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                message,
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              backgroundColor: Colors.deepPurple,
            )
        );
        showSpinner = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('save user info'),
        elevation: 0.0,
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 50)),
                Center(
                    child: Text("유저 정보 저장!")
                ),
                Form(
                    child: Theme(
                      data: ThemeData(
                          primaryColor: Colors.blue,
                          inputDecorationTheme: InputDecorationTheme(
                              labelStyle: TextStyle(color: Colors.teal,
                                  fontSize: 15.0))),
                      child: Container(
                        padding: EdgeInsets.all(50.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text("닉네임"),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: nicknamecontroller,
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text("이름"),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: namecontroller,
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 100,
                                    child: Text("성별"),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                        title: Text('남자'),
                                        value: 'man',
                                        groupValue: _gender,
                                        onChanged: (value) {
                                          setState(() {
                                            if (value != null) _gender = value;
                                          });
                                        }),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                        title: Text('여자'),
                                        value: 'woman',
                                        groupValue: _gender,
                                        onChanged: (value) {
                                          setState(() {
                                            if (value != null) _gender = value;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text("나이"),
                                ),
                                Expanded(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: _age,
                                    items: _ageList.map(
                                        (String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Center(
                                            child: Text(item, textAlign: TextAlign.center),),
                                          );
                                        }).toList(),
                                    onChanged: (dynamic value) {
                                      setState(() {
                                        _age = value;
                                      });
                                    },
                                  )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text("MBTI"),
                                ),
                                Expanded(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      value: _mbti,
                                      items: _mbtiList.map(
                                              (String item) {
                                            return DropdownMenuItem<String>(
                                              value: item,
                                              child: Center(
                                                child: Text(item, textAlign: TextAlign.center),),
                                            );
                                          }).toList(),
                                      onChanged: (dynamic value) {
                                        setState(() {
                                          _mbti = value;
                                        });
                                      },
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                                width: double.infinity,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    showSpinner = true;
                                    await _userInfoSaveInFireStore();
                                  },
                                  child: Text(
                                      "다음으로"
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orangeAccent
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}