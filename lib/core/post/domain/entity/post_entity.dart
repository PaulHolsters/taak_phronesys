class PostEntity {
  const PostEntity(
      {required this.id,
      required this.title,
      required this.body,
      required this.userId});

  final int id;
  final String title;
  final String body;
  final int userId;
}
