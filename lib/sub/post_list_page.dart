import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'post_data.dart';
import 'post_new_page.dart';
/*
class PostDetailPage extends StatefulWidget {
  final String id;

  const PostDetailPage({required this.id, Key? key}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  int _postLikes = 0;
  List<Comment> _comments = [];
  TextEditingController _commentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute
        .of(context)
        ?.settings
        .arguments as String;
    final post = postList.firstWhereOrNull((post) => post.id == postId);

    if (post == null) {
      return Scaffold(
        body: Center(
          child: Text('게시물을 찾을 수 없습니다.'),
        ),
      );
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NewPostPage(),)); // 새로운 게시물 작성 페이지
          },
        ),
        appBar: AppBar(
          title: Text('자유게시판'),
        ),
        body: ListView.builder(
          itemCount: postList.length,
          itemBuilder: (ctx, index) {
            final post = postList[index];
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PostDetailPage(id: post.id),
                ));
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
                        '${post.author} | ${post.createdAt}',
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

 */



