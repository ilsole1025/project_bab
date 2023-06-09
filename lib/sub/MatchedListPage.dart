import 'package:flutter/material.dart';
import 'package:project_bab/sub/DbGet.dart';

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
      body: FutureBuilder(
        future: getMatched(),
        builder : (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final List<Map<String,dynamic>> matchedList = snapshot.data?.map((mapData) => Map<String, dynamic>.from(mapData)).toList() ?? [];
          return ListView.builder( /// 여기부터 임시 화면구성
            itemCount: matchedList.length,
            itemBuilder: (ctx, index) {
              final Map<String,dynamic> matchedData = matchedList[index];
              return Container(
                height: 80,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        matchedData.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
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

