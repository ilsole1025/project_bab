import 'package:flutter/material.dart';
import 'package:project_bab/sub/DelAccount.dart';
import 'package:project_bab/sub/LoginPage.dart';
import 'package:project_bab/sub/userinfosave.dart';
import 'package:project_bab/sub/DbGet.dart';
import 'package:project_bab/widgets/app_large_text.dart';
import 'package:project_bab/widgets/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with TickerProviderStateMixin {
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('마이페이지',)
                    ]
                ),
              ),
         //     Icon(Icons.settings_outlined, color:Colors.black),
            ],
          )
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //정렬
          children: [
            SizedBox(height: 10,),
            // 프로필 자리
            Container(

              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween, //정렬
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15, top: 10),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    image: DecorationImage(
                    image: AssetImage("img/111.jpeg"), //프로필사진
                    fit: BoxFit.cover)),
                ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder( // 닉네임 불러와서 표시 (간단하게)
                          future: getUserData("nickname"),
                          builder: (context, snapshot){
                            return AppLargeText(
                              text: snapshot.data.toString(),
                              size: 22,
                            );
                          }
                      ),
                      AppText(text: "36.5도", color: Colors.redAccent),
                      AppText(text: "이것은 한줄소개입니다", size:15, color: Colors.black),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 20,),

            Divider(),

            SizedBox(
              height: 30,
            ),

            // 메인 기능 아이콘들
            Container(
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column( //1
                    children: [
                      SizedBox.fromSize(
                        size: Size(120, 120),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Material(
                            color: Colors.black12,
                            child: InkWell(
                              splashColor: Colors.green,
                              onTap: () {
                                print("프로필 버튼클릭");
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.person), // <-- Icon
                                  Text("Profile"), // <-- Text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                          child: AppText(
                            text: '내 프로필',
                            color: Colors.black,
                          )
                      ),
                    ],
                  ),
                  Column( // 2
                    children: [
                      SizedBox.fromSize(
                        size: Size(120, 120),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Material(
                            color: Colors.white,
                            child: InkWell(
                              splashColor: Colors.white70,
                              onTap: () {
                                print("약속목록 버튼 클릭");
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.list_alt), // <-- Icon
                                  Text("약속 목록"), // <-- Text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                          child: AppText(
                            text: '약속 목록',
                            color: Colors.black,
                          )
                      ),
                    ],
                  ),
                  Column( // 3
                    children: [
                      SizedBox.fromSize(
                        size: Size(120, 120),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Material(
                            color: Colors.white,
                            child: InkWell(
                              splashColor: Colors.white70,
                              onTap: () {
                                print("후기 버튼 클릭");
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.reviews), // <-- Icon
                                  Text("후기 목록"), // <-- Text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                          child: AppText(
                            text: '후기',
                            color: Colors.black,
                          )
                      ),
                    ],
                  )
                ],
              )
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column( // 4 프로필 수정
                      children: [
                        SizedBox.fromSize(
                          size: Size(120, 120),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Material(
                              color: Colors.white,
                              child: InkWell(
                                splashColor: Colors.white70,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          UserInterestSave())
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.edit_note), // <-- Icon
                                    Text("프로필수정"), // <-- Text
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                            child: AppText(
                              text: '프로필 수정',
                              color: Colors.black,
                            )
                        ),
                      ],
                    ),
                    Column( // 5
                      children: [
                        SizedBox.fromSize(
                          size: Size(120, 120),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Material(
                              color: Colors.white,
                              child: InkWell(
                                splashColor: Colors.white70,
                                onTap: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          LogIn())
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.logout), // <-- Icon
                                    Text("로그아웃"), // <-- Text
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),
                        Container(
                            child: AppText(
                              text: '로그아웃',
                              color: Colors.black,
                            )
                        ),
                      ],
                    ),
                    Column( // 6 탈퇴
                      children: [
                        SizedBox.fromSize(
                          size: Size(120, 120),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Material(
                              color: Colors.white,
                              child: InkWell(
                                splashColor: Colors.white70,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          DeleteAccount())
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.error), // <-- Icon
                                    Text("탈퇴"), // <-- Text
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),
                        Container(
                            child: AppText(
                              text: '탈퇴',
                              color: Colors.black,
                            )
                        ),
                      ],
                    )
                  ],
                )
            ),
            SizedBox(
              height: 30,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

}

class CircleTabIndicator extends Decoration {
  // Decoration위젯을 만들어서 위에 TabBar에서 사용
  // 색상과 radius를 전달받아서 사용한다
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // 원을 그려야 한다
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    // 가운데에 오게 한다
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
