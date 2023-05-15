import 'package:flutter/material.dart';
import 'post_data.dart';

class PostDetailPage extends StatefulWidget {
  final String id;
  final List<Post> postList;

  const PostDetailPage({required this.id, required this.postList, Key? key}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  int _postLikes = 0;
  List<Comment> _comments = []; //댓글을 유지하는 리스트
  TextEditingController _commentController = TextEditingController();

  /*@override
  void initState() {
    super.initState();
    _comments = widget.postList.firstWhere((post) => post.id == widget.id).comments;
  }*/

  @override
  Widget build(BuildContext context) {
    final postId = widget.id ?? ModalRoute.of(context)?.settings.arguments as String?;
    final post = widget.postList.firstWhere((post) => post.id == widget.id);

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
              Icon(Icons.notifications),
            ],
          )
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
              padding: const EdgeInsets.all(2),
              child: Text(
                '댓글',
                style: TextStyle(
                  fontSize: 10,
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
                    icon: Icon(Icons.thumb_up, size: 20),
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
                      id: '1',
                      postId: post.id,
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

class PostScreen extends StatelessWidget {
  final Post post;

  const PostScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                post.content,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Comments:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Column(
              children: post.comments.map((comment) => CommentView(comment: comment)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class PostView extends StatelessWidget {
  final Post post;

  const PostView({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.author),
      trailing: Text(post.likes.toString()),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostScreen(post: post),
          ),
        );
      },
    );
  }
}

class CommentView extends StatelessWidget {
  final Comment comment;

  const CommentView({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.content,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'by ${comment.author} at ${comment.createdAt}',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) => PostView(post: postList[index]),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'My App',
    home: HomeScreen(),
  ));
}
