import 'dart:convert';

import 'package:taak_phronesys/core/post/data/dto/post_dto.dart';
import 'package:http/http.dart' as http;

class PostDataSource {
  // dit zijn alle naakte API's, los van business betekenis, hier komen dus enkel DTO's in voor
  // per dto type moet je dus ook zo'n datasource hebben

  Future<List<PostDTO>> getPosts() async {
    Uri url = Uri.https('jsonplaceholder.typicode.com', 'posts');
 
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=utf8'
    });
    final body = json.decode(response.body);
    List<PostDTO> posts = [];
    for (final item in body) {
      posts.add(PostDTO.fromJson(item));
    }
    return posts;
  }

  Future<PostDTO> getPost(int id) async {
    Uri url = Uri.https('jsonplaceholder.typicode.com', 'posts/$id');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=utf8'
    });
    final body = json.decode(response.body);
    return PostDTO.fromJson(body);
  }

  Future<PostDTO> editPost(PostDTO post) async {
    print(post.title);
    print(post.toJson());
    print(post.toJson()['title']);
    print(post.toJson()['body']);
    Uri url = Uri.https('jsonplaceholder.typicode.com', 'posts/${post.id}');
    final response = await http.put(url, headers: {
      'Content-Type': 'application/json'
    },body: json.encode(post.toJson()));
    final body = json.decode(response.body);
    print('request is done');
    return PostDTO.fromJson(body);
  }

  Future<void> deletePost(int id) async {
    Uri url = Uri.https('jsonplaceholder.typicode.com', 'posts/$id');
    await http.delete(url, headers: {
      'Content-Type': 'application/json; charset=utf8'
    });
  }
}
