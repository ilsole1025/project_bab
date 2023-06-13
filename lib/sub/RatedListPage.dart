import 'package:flutter/material.dart';
import 'package:project_bab/sub/DbGet.dart';

import 'package:project_bab/widgets/app_large_text.dart';
import '../../widgets/app_text.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

/* 후기 목록 페이지 */

class RatedListPage extends StatefulWidget {
  const RatedListPage({Key? key}) : super(key: key);

  @override
  State<RatedListPage> createState() => _RatedListPageState();
}

class _RatedListPageState extends State<RatedListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          /// TODO : 상단바 수정
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Image.asset(
              'img/blacklogo.png',
              width: 90,
              height: 90,
            ),
            SizedBox(width: 30)
          ])),
      body: FutureBuilder(
        future: getMatched(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final List<Map<String, dynamic>> matchedList = snapshot.data
                  ?.map((mapData) => Map<String, dynamic>.from(mapData))
                  .toList() ??
              [];
          return ListView.builder(
              itemCount: matchedList.length,
              itemBuilder: (ctx, index) {
                final Map<String, dynamic> matchedData = matchedList[index];

                bool loading = true;
                if (matchedData['message'] == null) {
                  // print(matchedData['nickname'] + " 평가안매겼음");
                  loading = false;
                }

                return Container(
                  height: 150,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    //  matchedData.toString(),
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.fromLTRB(10, 10, 30, 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5),
                          image: DecorationImage(
                            image: AssetImage(
                              "profileImg/${matchedData['profileimg']}.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            AppLargeText(text: matchedData['nickname'], size: 25),
                            SizedBox(height: 7,),

                            if (loading) ...[ //후기가 작성된 경우
                              RatingBarIndicator(
                                rating: matchedData['rating'],
                                itemBuilder: (context, index) => Icon(
                                  Icons.favorite,
                                  color: Colors.red.shade300,
                                ),
                                itemCount: 5, itemSize: 25.0,
                                // direction: Axis.vertical,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child:
                                    Container(
                                      width: 250,
                                      child: Text(matchedData['message']),
                                    )
                              ),
                            ]
                            else ...[
                              AppText(text: '후기가 아직 작성되지 않았습니다.', color:Colors.red.shade200),
                            ]
                          ]),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}

