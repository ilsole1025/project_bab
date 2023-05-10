import 'package:flutter/material.dart';
import 'sub/1stPage.dart';
import 'sub/2ndPage.dart';
import 'sub/3rdPage.dart';
import 'sub/4thPage.dart';

// firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'sub/LoginPage.dart';


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
        primarySwatch: Colors.teal,
      ),
      home: LogIn(),
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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  TabController? controller;
  @override
  void initState(){
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
          children: <Widget>[FirstApp(), SecondApp(), ThirdApp(), MyPage()],
          controller: controller,
        ),
        bottomNavigationBar:TabBar(tabs: <Tab>[
          // 아이콘 찾기 : https://fonts.google.com/icons
          Tab(icon: Icon(Icons.home, color: Colors.teal),) ,
          Tab(icon: Icon(Icons.chat, color:  Colors.blue),),
          Tab(icon: Icon(Icons.dashboard, color: Colors.blue),) ,
          Tab(icon: Icon(Icons.person, color:  Colors.blue),)
        ], controller: controller,
        )
    );
  }


  @override
  void dispose(){
    controller!.dispose();
    super.dispose();
  }

}
