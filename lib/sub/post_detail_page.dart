import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:project_bab/sub/DbGet.dart';
import 'post_data.dart';
import 'dart:async';
import 'package:project_bab/main.dart';

class PostDetailPage extends StatefulWidget {
  final String id;
  final List<Map<String, dynamic>> postList;

  const PostDetailPage({required this.id, required this.postList, Key? key}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> with AutomaticKeepAliveClientMixin{
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
      if(mounted) {
        setState(() {});
      }
    });
  }


  @override
  Widget build(BuildContext context) {
      initializeDateFormatting(); // intl 패키지의 날짜 형식을 초기화
      super.build(context);
      final Map<String, dynamic> post = widget.postList.firstWhere((post) => post["id"] == widget.id);
      final now = DateTime.now();
      final difference = now.difference(post["createdAt"].toDate());
      String formattedTime;

      if (difference.inDays >= 1) {
        formattedTime = DateFormat('MM/dd HH:mm').format(post["createdAt"].toDate());
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
                    post["title"],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${post["author"]} | $formattedTime',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(post["content"]),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () async {
                          final uid = getUid();
                          if (post["likes"].contains(uid) == true) {
                            post["likes"].remove(uid);
                          } else {
                            post["likes"].add(uid);
                          }
                          final isLiked = await updateLike(post["id"]);
                          if(this.mounted) { setState(() {}); }
                        },
                        icon: Icon(Icons.thumb_up_outlined, color: Colors.red),
                        label: Text('좋아요 ${post["likes"].length}', style: TextStyle(color: Colors.red)),
                      ),
                      SizedBox(width: 8),
                      Row(
                        children: [
                          Icon(Icons.chat_bubble_outline, color: Colors.orange),
                          SizedBox(width: 6),
                          Text(
                            '댓글 ${post["commentCount"]}', // 댓글 수
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
            StreamBuilder<QuerySnapshot>(
              stream: db.collection("posts").doc(post["id"]).collection("comments").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final commentList = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: commentList.length,
                    itemBuilder: (ctx, index) {
                      final comment = commentList[index];
                      String formattedTimestamp = DateFormat('MM/dd HH:mm')
                          .format(comment["createdAt"].toDate());

                      return ListTile(
                        title: Text(comment["content"]),
                        subtitle: Text(
                            '${comment["author"]} | $formattedTimestamp'),
                      );
                    },
                  );
                }
              }
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
                onPressed: () async {
                  setState(() {
                    final Map<String,dynamic> comment = {
                      "id": '1',
                      "postId": post["id"],
                      "author": '익명',
                      "content": _commentController.text,
                      "createdAt": DateTime.now(),
                    };
                    setComment(post["id"], comment);
                    post["commentCount"]++;
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
