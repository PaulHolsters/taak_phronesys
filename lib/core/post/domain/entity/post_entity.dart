import 'package:taak_phronesys/core/post/domain/entity/comment_entity.dart';

class PostEntity {
   PostEntity(
      {required this.id,
      required this.title,
      required this.body,
      required this.userId,
      this.comments});

  final int id;
  String title;
  String body;
  final int userId;
  List<CommentEntity>? comments;
}
