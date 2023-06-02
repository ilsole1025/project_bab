import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'post_new_page.dart';
import 'post_detail_page.dart';
import 'post_data.dart';
import 'dart:async';
import 'DbGet.dart';
import 'package:project_bab/main.dart';

class ThirdApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return PostListPage();
  }
}

class PostListPage extends StatefulWidget {
  static const routeName = '/post-list';

  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push
            (MaterialPageRoute(builder: (context) => NewPostPage(),)); // 새로운 게시물 작성 페이지
        },
      ),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection("posts").snapshots(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final postList = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
          return ListView.builder(
            itemCount: postList.length,
            itemBuilder: (ctx, index) {
              final post = postList[index];
              final now = DateTime.now();
              final difference = now.difference(post["createdAt"].toDate());
              String formattedTime;

              if (difference.inDays > 0) {
                // 24시간 이상 전의 경우
                final formatter = DateFormat('MM/dd HH:mm');
                formattedTime = formatter.format(post["createdAt"].toDate());
              } else if (difference.inHours > 0) {
                // 1시간 이상 24시간 미만 전의 경우
                final hours = difference.inHours;
                final formatter = DateFormat('HH:mm');
                formattedTime = '$hours시간 전';
              } else if (difference.inMinutes > 0) {
                // 1분 이상 1시간 미만 전의 경우
                final minutes = difference.inMinutes;
                formattedTime = '$minutes분 전';
              } else {
                // 1분 이내인 경우
                formattedTime = '방금 전';
              }

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>PostDetailPage(id: post["id"], postList: postList),
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post["title"],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${post["author"]} | $formattedTime',
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.thumb_up_outlined, size: 16, color: Colors.red),
                                SizedBox(width: 4),
                                Text(
                                  '${post["likes"].length}', // 좋아요 수
                                  style: TextStyle(fontSize: 16, color: Colors.red,),
                                ),
                              ],
                            ),
                            SizedBox(width: 15),
                            Row(
                              children: [
                                Icon(Icons.chat_bubble_outline, size: 16, color: Colors.orange),
                                SizedBox(width: 4),
                                Text(
                                  '${post["commentCount"]}', // 댓글 수
                                  style: TextStyle(fontSize: 16, color: Colors.orange),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      )
      );
    }
  }