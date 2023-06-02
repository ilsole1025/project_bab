import 'package:flutter/material.dart';
import 'post_data.dart';
import 'DbGet.dart';

class NewPostPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      Text('게시글 쓰기',)
                    ]
                ),
              ),
            ],
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: '제목',
              ),
              maxLength: 20,
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: TextField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    hintText: '게시글은 삭제와 수정이 불가하니 신중하게 작성해주세요.',
                    contentPadding: EdgeInsets.all(16.0),
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  maxLength: 300,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final title = _titleController.text;
                final content = _contentController.text;

                // Create a new Post instance with the entered data
                final Map<String, dynamic> newPost = {
                  "id": DateTime.now().toString(),
                  "title": title,
                  "content": content,
                  "author": '익명',
                  "createdAt": DateTime.now(),
                  "likes": [],
                  "commentCount" : 0
                };

                // Add the new post to the postList
                await setPost(newPost);

                // Navigate back to the previous page
                Navigator.pop(context);
              },
              child: Text('확인'),
                        ),
                      ],
        ),
      ),
    );
  }
}