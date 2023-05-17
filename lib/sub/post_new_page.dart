import 'package:flutter/material.dart';
import 'post_data.dart';

class NewPostPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

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
                      Text("게시글 쓰기")
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
                    hintText: '내용을 입력하세요',
                    contentPadding: EdgeInsets.all(16.0),
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final content = _contentController.text;

                // Create a new Post instance with the entered data
                final newPost = Post(
                  id: DateTime.now().toString(),
                  title: title,
                  content: content,
                  author: '작성자',
                  createdAt: DateTime.now(),
                );

                // Add the new post to the postList
                postList.add(newPost);

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