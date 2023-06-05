
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_bab/main.dart';
import 'exception.dart';
import 'interest.dart';


class UserInfoSave extends StatefulWidget {
  const UserInfoSave({Key? key}) : super(key: key);

  @override
  State<UserInfoSave> createState() => _UserInfoSaveState();
}

class _UserInfoSaveState extends State<UserInfoSave> {
  final List<String> _ageList = ['선택하기','20','21','22','23','24','25','26','27','28','29','30'];
  TextEditingController nicknamecontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController kakaotalkidcontroller = TextEditingController();
  TextEditingController introductioncontroller = TextEditingController();
  String _gender = '', _age = '선택하기';

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
      "kakaotalkid": kakaotalkidcontroller.text,
      "introduction": introductioncontroller.text,
      "mannertemp": 36.5,
      "checked": true
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
        // 카카오톡 id 입력 안했을 때
        if(kakaotalkidcontroller.text == ''){
          throw myException('no-kakaotalkid');
        }
        // 한줄소개 입력 안했을 때
        if(kakaotalkidcontroller.text == ''){
          throw myException('no-introduction');
        }

        db.collection("users").doc("${currentUser.uid}").update(user);
        showSpinner = false;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>
            UserInterestSave())
        );
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
        } else if(e.toString() == 'no-kakaotalkid') {
          message = "카톡 아이디를 입력해주세요";
        } else if(e.toString() == 'no-introduction') {
          message = "한줄소개를 입력해주세요";
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
        backgroundColor: Colors.red[300],
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        //actions: <Widget>[
        //  IconButton(icon: Icon(Icons.search), onPressed: () {})
        //],
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
                                  child: Text("카카오톡 아이디"),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: kakaotalkidcontroller,
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
                                  child: Text("한줄소개"),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: introductioncontroller,
                                    keyboardType: TextInputType.name,
                                  ),
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


class UserInterestSave extends StatefulWidget {
  const UserInterestSave({Key? key}) : super(key: key);

  @override
  State<UserInterestSave> createState() => _UserInterestSaveState();
}

class _UserInterestSaveState extends State<UserInterestSave> {
  Map<String, List<String>> _interest_view = {
    "MBTI" : [],
    "성격" : [],
    "관심사" : [],
    "엔터테인먼트" : [],
    "스포츠" : [],
    "커리어" : []
  };
  Map<String, List<String>> _interest_value = {
    "MBTI" : [],
    "성격" : [],
    "관심사" : [],
    "엔터테인먼트" : [],
    "스포츠" : [],
    "커리어" : []
  };
  bool showSpinner = false;

  String _checkinterestList() {
    for (var entry in _interest_value.entries) {
      String key = entry.key;
      List<String> list = entry.value;
      int min = minSelectCountOfInterest[key] ?? 0;

      if (list.length < min) {
        return "${key} : ${min}개 이상 선택해야 합니다";
      }
    }
    return "true";
  }

  _saveinterest() async{
    String message = _checkinterestList();
    var currentUser = FirebaseAuth.instance.currentUser;
    final chk = <String, dynamic>{
      "checked": true
    };
    if (currentUser != null) {
      try {
        if(message != "true") throw Exception(message);
        final Map<String,List<String>> _interest_listmap = {"interests" : _interest_value.values.expand((values) => values).toList()};
        await db.collection("users").doc("${currentUser.uid}").update(_interest_value);
        await db.collection("users").doc("${currentUser.uid}").update(_interest_listmap);
        await db.collection("users").doc("${currentUser.uid}").update(chk);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(
                builder: (context) =>
                    MyHomePage(title: "bab")), (route) => false);
      } on Exception catch (e) {
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('save user interest'),
          elevation: 0.0,
          backgroundColor: Colors.red[300],
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {
            Navigator.pop(context);
          }),
          // actions: <Widget>[IconButton(icon: Icon(Icons.search), onPressed: () {}) ],
        ),
        body: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("나의 관심사", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                  Container(
                    height: 25,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _interest_value.values.fold<int>(0, (sum, list) => sum + list.length),
                      itemBuilder: (BuildContext context, int index) {
                        int sumLength = 0;
                        String key = '';
                        List<String> values = [];

                        for (final entry in _interest_view.entries) { // new
                          final list = entry.value;
                          if (index < sumLength + list.length) {
                            key = entry.key;
                            values = list;
                            break;
                          }
                          sumLength += list.length;
                        }

                        return Container(
                          height: 25,
                          width: values[index - sumLength].length * 12.0 + 25.0, // 20->25 상향
                          margin: EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
                              backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFFEBEBEB"))),
                              foregroundColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFF000000"))),
                              shadowColor: MaterialStateProperty.all<Color>(Color(int.parse("0xFFEBEBEB"))),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            child: Text(values[index - sumLength] + " ✖", style: TextStyle(fontSize: 12), textAlign: TextAlign.center), // x표시는 임시
                            onPressed: () {
                              setState(() {
                                _interest_view[key]!.removeAt(index - sumLength);
                                _interest_value[key]!.removeAt(index - sumLength);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  Container(
                    height: 10,
                    width: double.infinity,
                    color: Colors.white70,
                    margin: EdgeInsets.only(bottom: 20),
                  ),
                  Divider(),
                  Expanded(
                      child: Container(
                          height: INTEREST.length * 300,
                          width: double.infinity,
                          child: ListView.builder(
                              itemCount: INTEREST.length,
                              itemBuilder: (BuildContext context, int idx) {
                                String key = INTEREST.keys.elementAt(idx);
                                return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children:[
                                      Text(key, style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                                      Container(
                                          height: 25,
                                          width: double.infinity,
                                          margin: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: (INTEREST[key] as List<String>).length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return Container(
                                                  height: 25,
                                                  width: (INTEREST[key] as List<String>)[index].length * 12.0 + 20.0,
                                                  margin: EdgeInsets.only(right: 10),
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
                                                    child: Text((INTEREST[key] as List<String>)[index], style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                                                    onPressed: (){
                                                      if((_interest_view[key] as List<String>).length < (maxSelectCountOfInterest[key] ?? 0)) {
                                                        setState(() {
                                                          (_interest_view[key] as List<String>).add((INTEREST[key] as List<String>)[index]);
                                                          _interest_view[key] = (_interest_view[key.toString()] as List<String>).toSet().toList();
                                                          (_interest_value[key] as List<String>).add((INTEREST_VALUE[key] as List<String>)[index]);
                                                          _interest_value[key] = (_interest_value[key.toString()] as List<String>).toSet().toList();
                                                        });
                                                      }
                                                    },
                                                  )
                                              );
                                            },
                                          )
                                      ),
                                      Divider(),
                                    ]
                                );
                              }
                          )
                      )
                  ),

                  Container(
                      width: double.infinity,
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
                        child: Text("확인", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                        onPressed: () async{
                          await _saveinterest();
                        },
                      )
                  ),
                ]
            )
        )
    );
  }
}