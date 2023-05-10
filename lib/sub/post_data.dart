class Post {
  final String id;
  final String title;
  final String content;
  final String author;
  final DateTime createdAt;
  int likes;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
    this.likes = 0,
  });
}

class Comment {
  final String author;
  final String content;
  int likes;
  final DateTime createdAt;

  Comment({
    required this.author,
    required this.content,
    this.likes = 0,
    required this.createdAt,
  });
}

List<Post> postList = [
  Post(
    id: '1',
    title: '첫번째 게시글',
    content: '첫번째 게시글 내용',
    author: '작성자1',
    likes: 10,
    createdAt: DateTime.now(),
  ),
  Post(
    id: '2',
    title: '두번째 게시글',
    content: '두번째 게시글 내용',
    author: '작성자2',
    likes: 5,
    createdAt: DateTime.now(),
  ),
];