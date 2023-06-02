import 'package:flutter/material.dart';
import 'sub/1stPage.dart';
import 'sub/2ndPage.dart';
import 'sub/3rdPage.dart';
import 'sub/4thPage.dart';

// firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'sub/LoginPage.dart';
import 'package:flutter/cupertino.dart';

var db = FirebaseFirestore.instance;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: StreamBuilder<User?> (
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return MyHomePage(title: "밥먹공");
          } else{
            return LogIn();
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController? controller;
  Color selectedTabColor = Colors.black;
  Color unselectedTabColor = Colors.red;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller!.addListener(updateTabColors); // 탭 선택 시 색상 업데이트 리스너 추가
  }

  @override
  void dispose() {
    controller!.removeListener(updateTabColors); // 리스너 제거
    controller!.dispose();
    super.dispose();
  }

  void updateTabColors() {
    setState(() {
      // 선택된 탭 색상 업데이트
      selectedTabColor = Colors.black87;
      // 선택되지 않은 탭 색상 업데이트
      unselectedTabColor = Colors.black38;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        children: <Widget>[FirstApp(), SecondApp(), ThirdApp(), MyPage()],
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: TabBar(
        tabs: <Tab>[
          Tab(
            icon: Icon(Icons.home_rounded,
                color: controller?.index == 0 ? selectedTabColor : unselectedTabColor),
          ),
          Tab(
            icon: Icon(Icons.calendar_today_rounded,
                color: controller?.index == 1 ? selectedTabColor : unselectedTabColor),
          ),
          Tab(
            icon: Icon(Icons.space_dashboard_rounded,
                color: controller?.index == 2 ? selectedTabColor : unselectedTabColor),
          ),
          Tab(
            icon: Icon(Icons.person_rounded,
                color: controller?.index == 3 ? selectedTabColor : unselectedTabColor),
          ),
        ],
        controller: controller,
      ),
    );
  }

}
