import 'package:flutter/material.dart';
import 'package:project_bab/sub/LoginPage.dart';
import 'package:project_bab/widgets/app_large_text.dart';
import 'package:project_bab/widgets/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with TickerProviderStateMixin {
  var images ={
    "homeicon2.png":"지난 약속",
    "homeicon1.jpg":"받은 후기",
    "homeicon3.png":"나의 취향",
    "homeicon4.png":"내 프로필",
  };
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //정렬
          children: [
            // menu text
            Container(
                // 상단바
                padding: const EdgeInsets.only(top: 70, left: 20, right:20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_back_ios, size: 30, color: Colors.black54),
                    IconButton(
                        onPressed: (){
                      FirebaseAuth.instance.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                        LogIn())
                      );
                    },
                        icon: Icon(Icons.logout)),
                    Icon(Icons.notifications, size: 30, color: Colors.black54),
                  ],
                )
            ),
            SizedBox(
              height: 20,
            ), //위아래 공간 주기

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
                      AppLargeText(
                        text: "닉네임",
                        size: 22,
                      ),
                      AppText(text: "36.5도", color: Colors.redAccent),
                      AppText(text: "이것은 한줄소개입니다", size:15, color: Colors.black),
                      AppText(text: "프로필 수정 버튼은 여기에", size:15, color: Colors.grey),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),
            // 나의 알바트로스 레벨
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: AppLargeText(text: "나의 알바트로스 레벨", size:22),
            ),
            SizedBox(height: 10,),
            // tabbar
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                    labelPadding: const EdgeInsets.only(left: 20, right: 20),
                    controller: _tabController,
                    labelColor: Colors.teal,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: CircleTabIndicator(color: Colors.teal, radius: 4),
                    tabs: [
                      Tab(text: "약속예정목록"),
                      Tab(text: "지난 약속 목록"),
                      Tab(text: "Temp"),
                    ]),
              ),
            ),
            // 약속예정목록
            Container(
              padding: const EdgeInsets.only(left: 20),
              height: 150,
              width: double.maxFinite,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // 첫 번째 탭
                  ListView.builder(
                    itemCount: 3, //현재 예정 약속의 목록 개수
                    scrollDirection: Axis.horizontal, //가로로 스크롤
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 15, top: 10),
                        width: 200,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("img/111.jpeg"),
                                fit: BoxFit.cover)),
                      );
                    },
                  ),
                  // 두 번째 탭
                  Text("지난 약속 목록이나..리스트 들어갈 자리"),
                  // 세 번째 탭
                  Text("세 번째 탭에 들어갈 내용")
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, //정렬
                children: [
                  AppLargeText(
                    text: "나의 관심사",
                    size: 22,
                  ),
                  AppText(text: "See all", color: Colors.teal)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 120, width: double.maxFinite,
                margin: const EdgeInsets.only(left: 20),
                child: ListView.builder(
                    itemCount: 4, //후에 dynamic으로 바꿔야함
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 30),
                        child: Column(
                          children: [
                            Container(
                             // margin: const EdgeInsets.only(right: 50),
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: AssetImage("img/"+images.keys.elementAt(index)),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              child: AppText(
                                text: images.values.elementAt(index),
                                color: Colors.black,
                              )
                            )
                          ],
                        ),
                      );
                    }))
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
