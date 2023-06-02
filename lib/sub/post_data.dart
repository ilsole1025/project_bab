/*
class Post {
  final String id;
  final String title;
  final String content;
  final String author;
  final DateTime createdAt;
  int likes;
  List<Comment> comments;
  int commentCount; //댓글 수

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
    this.likes = 0,
    this.comments = const [],
    this.commentCount = 0,
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
*/

List<Map<String, dynamic>> postList = [];

List<String> postfieldList = [
  "id",
  "title",
  "content",
  "author",
  "createdAt",
  "likes",
  "commentCount",
];
