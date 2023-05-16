
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project_bab/sub/LoginPage.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  TextEditingController pwController = TextEditingController();

  bool showSpinner = false;
  bool isDeleted = false;
  String message = '';

  void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('회원 탈퇴'),
          content: const Text(
            '정말로 회원탈퇴하시겠습니까?\n삭제된 데이터는 복구할 수 없습니다',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // No
              },
              child: const Text('아니요'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Yes
              },
              child: const Text('네'),
            ),
          ],
        );
      },
    ).then((result) async {
      if (result == true) {
        setState(() {
          showSpinner = true;
        });
        await deleteAccountData();
      }
      if(isDeleted == true) {
        isDeleted = false;
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(
                builder: (context) =>
                    LogIn()), (route) => false);
      }
    });
  }

  Future<void> deleteAccountData() async {
    message = '';
    try {
      if (pwController.text == '') {
        throw FirebaseAuthException(code: 'empty-password');
      }

      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw FirebaseAuthException(code: 'user-not-logged-in');
      }
      String email = user.email!;
      String password = pwController.text;

      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

      // 계정 삭제
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
        await user.delete();
        message = '계정이 성공적으로 삭제되었습니다';
        isDeleted = true;
      } catch (e) {
        message = 'Error deleting data : $e';
      }

      setState(() {
        showSpinner = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        showSpinner = false;
      });
      if (e.code == 'empty-password') {
        message = '비밀번호를 입력하세요';
      } else if (e.code == 'user-not-logged-in') {
        message = '다시 로그인 후 재시도해 주세요';
      } else if (e.code == 'wrong-password') {
        message = '잘못된 비밀번호입니다';
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
        title: Text('회원 탈퇴'),
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
                    child: Text("회원 탈퇴")
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
                              controller: pwController,
                              decoration: InputDecoration(labelText: '비밀번호'),
                              obscureText: true,
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(height: 20.0,),
                            Container(
                              child: ElevatedButton(
                                  onPressed: () {
                                    _showConfirmDialog(context);
                                  },
                                  child: Text("회원 탈퇴")),
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