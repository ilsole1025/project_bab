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

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('자유게시판',)
                    ]
                ),
              ),
              Icon(Icons.notifications_outlined, color: Colors.black),
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
                  SizedBox(height: 5),
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
                            else {
                              _postLikes--;
                              _isLiked = false;
                            }
                          });
                        },
                        icon: Icon(Icons.thumb_up_outlined, color: Colors.red),
                        label: Text('좋아요 ${post.likes}', style: TextStyle(color: Colors.red)),
                      ),
                      SizedBox(width: 8),
                      Row(
                        children: [
                          Icon(Icons.chat_bubble_outline, color: Colors.orange),
                          SizedBox(width: 6),
                          Text(
                            '댓글 ${post.commentCount}', // 댓글 수
                            style: TextStyle(color: Colors.orange),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(1),
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
                String formattedTimestamp = DateFormat('MM/dd HH:mm').format(comment.createdAt);

                return ListTile(
                  title:Text(comment.content),
                  subtitle: Text('${comment.author} | $formattedTimestamp'),
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
                maxLength: 100,
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
