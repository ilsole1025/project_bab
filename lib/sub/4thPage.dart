import 'package:flutter/material.dart';
import 'package:project_bab/sub/DelAccount.dart';
import 'package:project_bab/sub/LoginPage.dart';
import 'package:project_bab/sub/MatchedListPage.dart';
import 'package:project_bab/sub/RatedListPage.dart';
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
    var imgNum;
    String imgUrl = "";



    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'img/blacklogo.png',
                  width: 90,
                  height: 90,
                ),
              ])
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //정렬
          children: [
            SizedBox(height: 10,),
            // 프로필 자리


            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("img/header.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 140,
                      left: 20,
                      child: FutureBuilder( // imgNum불러오기
                        future: getUserData("profileimg"),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            imgNum = snapshot.data.toString();
                            imgUrl = "profileImg/$imgNum.jpg";
                            return
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 5),
                                  image: DecorationImage(
                                    //image: AssetImage("profileImg/$imgNum.jpg";),
                                    image: AssetImage(imgUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                          } else {
                            return Container(); // 데이터가 없을 경우 아무것도 보여주지 않음
                          }
                        },
                      )

                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment(0.8, 0.0),
              margin: const EdgeInsets.only(left: 0, right: 0, top: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserInterestSave()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // 배경색을 투명하게 설정
                  side: BorderSide(color: Colors.black), // 선 색을 검정으로 설정
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '프로필 편집',
                    style: TextStyle(color: Colors.black), // 글자 색을 검정으로 설정
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 40, right: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                    future: getUserData("nickname"),
                    builder: (context, snapshot) {
                      return AppLargeText(
                          text: snapshot.data.toString(),
                          size: 22,
                      );
                    },
                  ),
                  SizedBox(height: 5,),
                  FutureBuilder(
                    future: getUserData("mannertemp"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return AppText(
                          text: snapshot.data.toString() + ' °C',
                          color: Colors.redAccent,
                        );
                      } else {
                        return Container(); // 데이터가 없을 경우 아무것도 보여주지 않음
                      }
                    },
                  ),
                  SizedBox(height: 5,),
                  FutureBuilder(
                    future: getUserData("introduction"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return AppText(
                          text: snapshot.data.toString(),
                        );
                      } else {
                        return Container(); // 데이터가 없을 경우 아무것도 보여주지 않음
                      }
                    },
                  ),
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
                                //print("약속목록 버튼 클릭");
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MatchedListPage()));
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const RatedListPage()));
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
                    Column( // 4. 프로필 수정
                      children: [
                        SizedBox.fromSize(
                          size: Size(120, 120),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Material(
                              color: Colors.red[50],
                              child: InkWell(
                                splashColor: Colors.white,
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
