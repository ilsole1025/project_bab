import 'package:flutter/material.dart';
import 'post_detail_page.dart';
import 'post_data.dart';

class PostListPage extends StatelessWidget {
  static const routeName = '/post-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('자유게시판'),
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
