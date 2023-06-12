import 'package:flutter/material.dart';
import 'package:project_bab/sub/DbGet.dart';

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
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  //  matchedData.toString(),
                  children: [
                    Text( matchedData['nickname'],style: const TextStyle(fontSize: 22),
                    ),
                    Text( matchedData['timestamp'],style: const TextStyle(fontSize: 16),
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

