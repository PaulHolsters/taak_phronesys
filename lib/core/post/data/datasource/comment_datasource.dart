import 'dart:convert';

import 'package:taak_phronesys/core/post/data/dto/comment_dto.dart';
import 'package:taak_phronesys/core/post/data/dto/post_dto.dart';
import 'package:http/http.dart' as http;

class CommentDataSource {
  // dit zijn alle naakte API's, los van business betekenis, hier komen dus enkel DTO's in voor
  // per dto type moet je dus ook zo'n datasource hebben

  Future<List<CommentDTO>> getComments(int postId) async {
    Uri url = Uri.https('jsonplaceholder.typicode.com', 'posts/$postId/comments');
 
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=utf8'
    });
    final body = json.decode(response.body);
    List<CommentDTO> comments = [];
    for (final item in body) {
      comments.add(CommentDTO.fromJson(item));
    }
    return comments;
  }
}