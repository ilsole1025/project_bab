import 'package:flutter/material.dart';
import 'post_detail_page.dart';
import 'post_data.dart';

class ThirdApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body : Container(
        child: Center(
          child: ElevatedButton(
            child: Text('세번째 페이지'),
            onPressed: () {
              Navigator.pushNamed(context, PostListPage.routeName);
            },
          ),
        ),
      ),
    );
  }
}

class PostListPage extends StatelessWidget {
  static const routeName = '/post-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시판'),
      ),
      body: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (ctx, index) {
          final post = postList[index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                PostDetailPage.routeName,
                arguments: post.id,
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