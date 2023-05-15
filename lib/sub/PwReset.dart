// CreatePage

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project_bab/main.dart';
import 'package:project_bab/sub/LoginPage.dart';

class PwReset extends StatefulWidget {
  const PwReset({Key? key}) : super(key: key);

  @override
  State<PwReset> createState() => _PwResetState();
}

class _PwResetState extends State<PwReset> {
  TextEditingController emailcontroller = TextEditingController();

  bool showSpinner = false;

  _PasswordReset() async {
    String message = '';
    try {
      if (emailcontroller.text == '') {
        throw FirebaseAuthException(code: 'empty-email');
      } else if (emailcontroller.text.substring(emailcontroller.text.indexOf('@')) != '@sogang.ac.kr') {
        throw FirebaseAuthException(code: 'not-sogang');
      }
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text)
          .then((value){
        message = '비밀번호 재설정 이메일이 발송되었습니다';
      });

      setState(() {
        showSpinner = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        showSpinner = false;
      });
      if (e.code == 'empty-email') {
        message = '이메일을 입력하세요';
      } else if (e.code == 'invalid-email') {
        message = '이메일 형식이 올바르지 않습니다.';
      } else if (e.code == 'not-sogang') {
        message = '서강대학교 이메일을 이용해주세요';
      } else if (e.code == 'user-not-found') {
        message = '해당 이메일의 계정이 존재하지 않습니다';
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비밀번호 재설정'),
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
                    child: Text("비밀번호 재설정 이메일 발송")
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
                            SizedBox(height: 20.0,),
                            Container(
                              child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      showSpinner = true;
                                    });
                                    await _PasswordReset();
                                  },
                                  child: Text("비밀번호 재설정")),
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
