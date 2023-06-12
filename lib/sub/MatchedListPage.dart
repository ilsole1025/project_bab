import 'package:flutter/material.dart';
import 'package:project_bab/sub/DbGet.dart';

import 'package:project_bab/widgets/app_large_text.dart';
import '../../widgets/app_text.dart';
// 약속 목록

class MatchedListPage extends StatefulWidget {
  const MatchedListPage({Key? key}) : super(key: key);

  @override
  State<MatchedListPage> createState() => _MatchedListPageState();
}

class _MatchedListPageState extends State<MatchedListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( /// TODO : 상단바 수정
          backgroundColor: Colors.red[300],
          foregroundColor: Colors.white,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('약속 목록'),
               // Image.asset('img/logo.png',width: 90,height: 90, ),
              ])
      ),

      body: FutureBuilder(
        future: getMatched(),
        builder : (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final List<Map<String,dynamic>> matchedList =
              snapshot.data?.map((mapData) => Map<String, dynamic>.from(mapData)).toList() ?? [];
          return ListView.builder( /// TODO : 여기부터 임시 화면구성
            itemCount: matchedList.length,
            itemBuilder: (ctx, index) {
              final Map<String,dynamic> matchedData = matchedList[index];
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
                      width: 120,height: 120,
                      margin: EdgeInsets.fromLTRB(10, 10, 30, 10),
                      decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 5),
                      image: DecorationImage(image: AssetImage("profileImg/${matchedData['profileimg']}.jpg",),fit: BoxFit.cover,
                      ),
                    ),
                  ),

                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                        AppLargeText(text: matchedData['nickname'], size:25),
                        AppText(text:"\n약속날짜\n"+matchedData['timestamp'],),
                      ]
                    ),

                  ],
                ),
              );
            }
          );
        },
      ),
    );
  }
}

