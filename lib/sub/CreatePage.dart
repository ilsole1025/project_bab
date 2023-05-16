// CreatePage

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project_bab/main.dart';
import 'package:project_bab/sub/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'exception.dart';

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController password1controller = TextEditingController();
  TextEditingController password2controller = TextEditingController();

  bool showSpinner = false;

  _makeFirestore(value) {
    final user = <String, dynamic> {
      "uid": "${value.user!.uid}",
      "checked" : false,
    };
    db.collection("users").doc("${value.user!.uid}").set(user);
  }

  void _showCreatedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('회원 가입 완료'),
          content: const Text(
            '인증 메일이 발송되었으니 확인해 주세요.',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // No
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    ).then((result) {
      if (result == true) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(
                builder: (context) =>
                    LogIn()), (route) => false);
      }
    });
  }

  _checkValidAccount() async {
    try {
      if (emailcontroller.text == '') {
        throw FirebaseAuthException(code: 'empty-email');
      }
      if (password1controller.text == '' || password2controller.text == '') {
        throw FirebaseAuthException(code: 'empty-password');
      }
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: password1controller.text)
          .then((value){
        if(value.user!.email == '') {
          throw FirebaseAuthException(code: 'empty-email');
        }
          // 비밀번호 확인
        if (password1controller.text != password2controller.text){
            throw FirebaseAuthException(code : "password-missmatch");
          }
          //
        if (emailcontroller.text.substring(emailcontroller.text.indexOf('@')) != '@sogang.ac.kr') {
            throw FirebaseAuthException(code: "not-sogang");
          }
        _makeFirestore(value);
        return value;});
      FirebaseAuth.instance.currentUser?.sendEmailVerification();

      setState(() {
        showSpinner = false;
      });

      _showCreatedDialog(context);
    } on FirebaseAuthException catch (e) {
      setState(() {
        showSpinner = false;
      });
      String message = '';
      if (e.code == 'empty-email') {
        message = '이메일을 입력하세요';
      } else if (e.code == 'email-already-in-use') {
        message = '이미 가입하셨네요!';
      } else if (e.code == 'empty-password') {
        message = '비밀번호를 입력하세요';
      } else if (e.code == 'invalid-email') {
        message = '이메일 형식이 올바르지 않습니다.';
      } else if (e.code == 'password-missmatch') {
        message = '비밀번호가 다릅니다';
      } else if (e.code == 'not-sogang') {
        message = '서강대학교 이메일을 이용해주세요';
      } else if (e.code == 'weak-password'){
        message = '취약한 비밀번호입니다.';
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
        title: Text('회원가입'),
        elevation: 0.0,
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {
          Navigator.pop(context);
        }),
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
                    child: Text("회원가입!")
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
                                  controller: password1controller,
                                  decoration: InputDecoration(labelText: '비밀번호'),
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: true,
                                ),
                                TextField(
                                  controller: password2controller,
                                  decoration: InputDecoration(labelText: '비밀번호 확인'),
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: true,
                                ),
                                SizedBox(height: 20.0,),
                                Container(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          showSpinner = true;
                                        });
                                        return _checkValidAccount();
                                      },
                                      child: Text("이메일 인증하기")),
                                )
                              ],
                            ),
                          )),
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
