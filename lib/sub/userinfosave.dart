
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
  final List<String> _mbtiList = ['infp','infj','intp','intj','isfp','isfj','istp','istj','enfp','enfj','entp','entj','esfp','esfj','estp','estj'];
  TextEditingController nicknamecontroller = TextEditingController();
  String _gender = '', _age = '선택하기', _mbti = 'intp'; // 아직 mbti 입력창을 못 만들어서 임의의 값으로 초기화

  bool showSpinner = false;


  _userInfoSaveInFireStore() {
    var currentUser = FirebaseAuth.instance.currentUser;
    final user = <String, dynamic>{
      "nickname": nicknamecontroller.text,
      "age": _age,
      "gender": _gender,
      "mbti": _mbti,
      "checked": true,
    };
    if (currentUser != null) {
      try {
        // 닉네임
        if(nicknamecontroller.text == ''){
          throw myException('no-name'); // 닉네임 입력 안했을 때
        } else if(nicknamecontroller.text.length < 2 || nicknamecontroller.text.length > 10){
          throw myException('exceed-name'); // 닉네임 2~10글자 사이로 제한(임시)
        } else if(nicknamecontroller.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
          throw myException('special-name'); // 닉네임에 특수 문자가 포함될 때
        }
        // 나이 입력 안했을 때
        if(_age == '선택하기'){
          throw myException('no-age');
        }
        // 성별 입력 안했을 때
        if(_gender == ''){
          throw myException('no-gender');
        }
        // mbti 입력 안했을 때
        if(_mbti == ''){
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
        if (e.toString() == 'no-name') {
          message = "닉네임을 입력해주세요";
        } else if(e.toString() == 'exceed-name') {
          message = "닉네임은 2글자에서 10글자 사이여야 합니다";
        } else if(e.toString() == 'special-name') {
          message = "닉네임에 특수문자를 사용할 수 없습니다";
        } else if(e.toString() == 'no-age') {
          message = "나이를 선택해주세요";
        } else if(e.toString() == 'no-gender') {
          message = "성별을 선택해주세요";
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
                            Container(
                                width: double.infinity,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: (){
                                    showSpinner = true;
                                    _userInfoSaveInFireStore();
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