class CommentDTO{

    CommentDTO({
      this.id,
      this.name,
      this.email,
      this.body,
      this.postId

    });

    int? id;
    String? name;
    String? email;
    String? body;
    int? postId;

    factory CommentDTO.fromJson(Map<String,dynamic> json) => CommentDTO(
      id: json['id'],
      name:json['name'],
      email:json['email'],
      body:json['body'],
      postId: json['postId'],
    );

    Map<String, dynamic> toJson() => {
      'id':id,
      'name':name,
      'email':email,
      'body':body,
      'postId':postId
    };
}