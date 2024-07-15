import 'package:json_annotation/json_annotation.dart';
part 'post_dto.g.dart';

@JsonSerializable()
class PostDTO{

    PostDTO({
      this.id,
      this.title,
      this.body,
      this.userId

    });

    int? id;
    String? title;
    String? body;
    int? userId;

    factory PostDTO.fromJson(Map<String,dynamic> json) => PostDTO(
      id: json['id'],
      title:json['title'],
      body:json['body'],
      userId: json['userId'],
    );

    Map<String, dynamic> toJson() => {
      'id':id,
      'title':title,
      'body':body,
      'userId':userId
    };
}