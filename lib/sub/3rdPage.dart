import 'package:flutter/material.dart';

import 'post_detail_page.dart';
import 'post_data.dart';

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
    return Scaffold(
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
                      //Icon(Icons.arrow_back),
                      Text("자유게시판")
                    ]
                ),
              ),
              Icon(Icons.add),
              Icon(Icons.notifications),
            ],
          )
      ),
      body: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (ctx, index) {
          final post = postList[index];
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      post.author,
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