import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'post_new_page.dart';
import 'post_detail_page.dart';
import 'post_data.dart';
import 'dart:async';

class ThirdApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return PostListPage();
  }
}

class PostListPage extends StatelessWidget {
  static const routeName = '/post-list';

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting(); // intl 패키지의 날짜 형식을 초기화

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewPostPage(),)); // 새로운 게시물 작성 페이지
        },
      ),
      appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 80,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      //Icon(Icons.arrow_back_ios),
                      Text("자유게시판")
                    ]
                ),
              ),
              Icon(Icons.notifications),
            ],
          )
      ),
      body: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (ctx, index) {
          final post = postList[index];
          final now = DateTime.now();
          final difference = now.difference(post.createdAt);
          String formattedTime;

          if (difference.inDays > 0) {
            // 24시간 이상 전의 경우
            final formatter = DateFormat('MM/dd HH:mm');
            formattedTime = formatter.format(post.createdAt);
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
                  builder: (context) =>PostDetailPage(id: post.id, postList: postList),
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
                      post.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${post.author} | $formattedTime',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}