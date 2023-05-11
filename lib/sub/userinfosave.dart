
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
  TextEditingController namecontroller = TextEditingController();
  String _gender = '';
  List<String> _ageList = ['선택하기','20','21','22','23','24','25','26','27','28','29','30'];
  String _age = '선택하기';

  bool showSpinner = false;


  _userInfoSaveInFireStore() {
    var currentUser = FirebaseAuth.instance.currentUser;
    final user = <String, dynamic>{
      "name": namecontroller.text,
      "age": _age,
      "gender": _gender,
      "checked": true,
    };
    if (currentUser != null) {
      try {
        // 이름 입력 안했을 때
        if(namecontroller.text == ''){
          throw myException('no-name');
        }
        // 성별 입력 안했을 때
        if(_gender == ''){
          throw myException('no-gender');
        }
        // 나이 입력 안했을 때
        if(_age == '선택하기'){
          throw myException('no-age');
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
        } else if(e.toString() == 'no-gender') {
          message = "성별을 선택해주세요";
        } else if(e.toString() == 'no-age') {
          message = "나이를 선택해주세요";
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