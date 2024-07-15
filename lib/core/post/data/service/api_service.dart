import 'package:dartz/dartz.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:taak_phronesys/core/post/data/datasource/failure.dart';
import 'package:taak_phronesys/core/post/data/dto/post_dto.dart';
part 'api_service.g.dart';



@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class ApiService{
  factory ApiService(Dio dio) = _ApiService;

  @GET('posts')
  Future<Either<List<PostDTO>,Failure>> getPosts();
}