import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:taak_phronesys/core/post/data/dto/post_dto.dart';
class PostDataSource{
  // deze klasse voert effectief de usecase uit van de verschillende usecases die er zijn

  Future<List<PostDTO>> getPosts() async{
          Uri url = Uri.https(
          'https://jsonplaceholder.typicode.com', 'posts');
      final response = await http.get(url,
          headers: {'Content-Type': 'application/json; charset=UTF-8'});
      final body = json.decode(response.body);
      List<PostDTO> posts = [];
      for(final item in body){
          posts.add(PostDTO.fromJson(item));
      }    
      return posts;    
  }
}