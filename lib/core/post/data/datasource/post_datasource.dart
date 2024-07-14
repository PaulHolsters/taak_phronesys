import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:taak_phronesys/core/post/data/datasource/failure.dart';
import 'package:taak_phronesys/core/post/data/dto/post_dto.dart';
import 'package:http/http.dart' as http;

class PostDataSource {

  Future<Either<List<PostDTO>,Failure>> getPosts() async {
    Uri url = Uri.https('jsonplaceholder.typicode.com', 'posts');
    // todo check if there is internet if not => Failure
    // todo if the response isn't there after one minute => Failure
    
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json'
    });
    if(response.statusCode!=200){
      return const Right(Failure('Something went wrong. Try again later!'));
    }
    final body = json.decode(response.body);
    List<PostDTO> posts = [];
    for (final item in body) {
      posts.add(PostDTO.fromJson(item));
    }
    return Left(posts);
  }

  Future<Either<PostDTO,Failure>> getPost(int id) async {
    Uri url = Uri.https('jsonplaceholder.typicode.com', 'posts/$id');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json'
    });
    if(response.statusCode!=200){
      return const Right(Failure('Something went wrong. Try again later!'));
    }
    final body = json.decode(response.body);
    return Left(PostDTO.fromJson(body));
  }

  Future<Either<PostDTO,Failure>> editPost(PostDTO post) async {
    Uri url = Uri.https('jsonplaceholder.typicode.com', 'posts/${post.id}');
    final response = await http.put(url, headers: {
      'Content-Type': 'application/json; charset=utf-8'
    },body: json.encode(post.toJson()));
    if(response.statusCode!=200){
      return const Right(Failure('Something went wrong. Try again later!'));
    }
    final body = json.decode(response.body);
    // todo return null hier
    return Left(PostDTO.fromJson(body));
  }

  Future<Either<void,Failure>> deletePost(int id) async {
    Uri url = Uri.https('jsonplaceholder.typicode.com', 'posts/$id');
    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json'
    });
    if(response.statusCode!=200){
      return const Right(Failure('Something went wrong. Try again later!'));
    }
    return const Left(null);
  }
}
