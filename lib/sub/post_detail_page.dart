import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'post_data.dart';
import 'dart:async';


class PostDetailPage extends StatefulWidget {
  final String id;
  final List<Post> postList;

  const PostDetailPage({required this.id, required this.postList, Key? key}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> with AutomaticKeepAliveClientMixin{
  bool _isLiked = false; //좋아요 상태 저장 변수
  int _postLikes = 0;
  List<Comment> _comments = []; //댓글을 유지하는 리스트
  TextEditingController _commentController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    updatePostTime();
    // 상태 초기화 등의 작업
  }

  void updatePostTime() {
    Timer.periodic(const Duration(minutes: 1), (Timer timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
      initializeDateFormatting(); // intl 패키지의 날짜 형식을 초기화
      super.build(context);
      final post = widget.postList.firstWhere((post) => post.id == widget.id);
      final now = DateTime.now();
      final difference = now.difference(post.createdAt);
      String formattedTime;

      if (difference.inDays >= 1) {
        formattedTime = DateFormat('MM/dd HH:mm').format(post.createdAt);
      } else if (difference.inHours >= 1) {
        formattedTime = '${difference.inHours}시간 전';
      } else if (difference.inMinutes >= 1) {
        formattedTime = '${difference.inMinutes}분 전';
      } else {
        formattedTime = '방금';
      }
      //final postId = widget.id ?? ModalRoute.of(context)?.settings.arguments as String?;

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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${post.author} | $formattedTime',
                    style: const TextStyle(
                      fontSize: 12,
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
                            if(! _isLiked){
                              _postLikes++;
                              _isLiked = true;
                            }
                          });
                        },
                        icon: Icon(Icons.thumb_up, color: Colors.grey),
                        label: Text('좋아요 $_postLikes', style: TextStyle(color: Colors.grey)),
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
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment.content),
                    ]
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
                      author: '작성자',
                      content: _commentController.text,
                      //likes: 0,
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
