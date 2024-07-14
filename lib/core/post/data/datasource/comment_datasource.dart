import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:taak_phronesys/core/post/data/datasource/failure.dart';
import 'package:taak_phronesys/core/post/data/dto/comment_dto.dart';
import 'package:http/http.dart' as http;

class CommentDataSource {
  Future<Either<List<CommentDTO>,Failure>> getComments(int postId) async {
    Uri url = Uri.https('jsonplaceholder.typicode.com', 'posts/$postId/comments');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=utf8'
    });
    if(response.statusCode!=200){
      return const Right(Failure('Something went wrong. Try again later'));
    }
    final body = json.decode(response.body);
    List<CommentDTO> comments = [];
    for (final item in body) {
      comments.add(CommentDTO.fromJson(item));
    }
    return Left(comments);
  }
}