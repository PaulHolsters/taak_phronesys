import 'package:dartz/dartz.dart';
import 'package:taak_phronesys/core/post/data/datasource/failure.dart';
import 'package:taak_phronesys/core/post/data/mapper/mapper.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';

abstract class PostRepository{
  Mapper mapper = Mapper();

  Future<Either<List<PostEntity>,Failure>> getPosts();
  Future<Either<PostEntity,Failure>> getPost(int postId);
  Future<Either<PostEntity,Failure>> editPost(PostEntity post);
  Future<Either<void,Failure>> deletePost(int postId);
}