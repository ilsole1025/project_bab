// LoginPage

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:project_bab/main.dart';
import 'package:project_bab/sub/PwReset.dart';
import 'CreatePage.dart';
import 'userinfosave.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';



class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  bool showSpinner = false;



  _authentication() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text)
          .then((value) async {
        if(value.user!.emailVerified == true) {

          var snapshot = await db.collection("users").doc(value.user!.uid).get();

          bool checking = snapshot.data()!['checked'];
          if(!checking){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                UserInfoSave())
            );
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    MyHomePage(title: "bab"))
            );
          }
        } else {
          throw FirebaseAuthException(code: 'not-verified');
        }
        setState(() {
          showSpinner = false;
        });
        return value;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        showSpinner = false;
      });
      String message = '';
      if(e.code == 'user-not-found'){
        message = '존재하지 않는 이메일입니다.';
      } else if(e.code == 'not-verified') {
        message = '인증이 완료되지 않았습니다.';
      } else if (e.code == 'wrong-password'){
        message = '비밀번호를 확인하세요.';
      } else if (e.code == 'invalid-email'){
        message = '이메일을 확인하세요.';
      } else {
        message = '올바른 형식이 아니에요.';
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
        elevation: 0.0,
        backgroundColor: Colors.red[300],
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
      //  actions: <Widget>[
      //   IconButton(icon: Icon(Icons.search), onPressed: () {})
      //  ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 50)),
                Center(
                  child: Text("로그인!")
                ),
                Form(
                    child: Theme(
                      data: ThemeData(
                          primaryColor: Colors.blue,
                          inputDecorationTheme: InputDecorationTheme(
                              labelStyle: TextStyle(color: Colors.teal, fontSize: 15.0))),
                      child: Container(
                          padding: EdgeInsets.all(50.0),
                            child: Column(
                                children: [
                                  TextField(
                                    controller: emailcontroller,
                                    decoration: InputDecoration(labelText: '이메일'),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  TextField(
                                    controller: passwordcontroller,
                                    decoration:
                                    InputDecoration(labelText: '비밀번호'),
                                    keyboardType: TextInputType.text,
                                    obscureText: true, // 비밀번호 안보이도록 하는 것
                                  ),
                                  SizedBox(height: 40.0,),
                                  Container(
                                      width: double.infinity,
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: (){
                                          setState(() {
                                            showSpinner = true;
                                          });
                                          return _authentication();
                                        },
                                        child: Text(
                                          "로그인"
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.orangeAccent
                                        ),
                                      )
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                      width: double.infinity,
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                          Create()));
                                        },
                                        child: Text(
                                            "회원가입",
                                          style: TextStyle(
                                            color: Colors.black
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white
                                        ),
                                      )
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                      width: 120,
                                      height: 40,
                                      child: TextButton(
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                              PwReset()));
                                        },
                                        child: Text(
                                          "비밀번호 재발급",
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                        ),
                                      )
                                  )
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

