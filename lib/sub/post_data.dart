class Post {
  final String id;
  final String title;
  final String content;
  final String author;
  final DateTime createdAt;
  int likes;
  List<Comment> comments;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
    this.likes = 0,
    this.comments = const [],
  });
}

class Comment {
  final String id;
  final String postId;
  final String content;
  final String author;
  final DateTime createdAt;
  int likes;

  Comment({
    required this.id,
    required this.postId,
    required this.content,
    required this.author,
    required this.createdAt,
    this.likes = 0,
    });
}


List<Post> postList = [
  Post(
    id: '1',
    title: '첫번째 게시글',
    content: '첫번째 게시글 내용 라라라라라라ㅏ랄',
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