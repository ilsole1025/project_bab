import 'package:flutter/material.dart';
import 'post_data.dart';

class PostDetailPage extends StatefulWidget {
  static const routeName = '/post-detail';

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
    final post = postList.firstWhere((post) => post.id == postId);

    return Scaffold(
      appBar: AppBar(
        title: Text('게시글'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(post.content),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          setState(() {

                            _postLikes++;
                          });
                        },
                        icon: Icon(Icons.thumb_up),
                        label: Text('좋아요 $_postLikes'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '댓글',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _comments.length,
              itemBuilder: (ctx, index) {
                final comment = _comments[index];
                return ListTile(
                  title: Text(comment.author),
                  subtitle: Text(comment.content),
                  trailing: TextButton.icon(
                    onPressed: () {
                      setState(() {
                        comment.likes++;
                      });
                    },
                    icon: Icon(Icons.thumb_up),
                    label: Text(comment.likes.toString()),
                  ),
                );
              },
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '댓글 작성',
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    final comment = Comment(
                      author: '사용자',
                      content: _commentController.text,
                      likes: 0,
                      createdAt: DateTime.now(), //현재 시간 할당
                    );
                    _comments.add(comment);
                    _commentController.clear();
                  });
                },
                child: Text('등록'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}