import 'package:dartz/dartz.dart';
import 'package:taak_phronesys/core/post/data/datasource/failure.dart';
import 'package:taak_phronesys/core/post/domain/repository/post_repository.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';

class GetPostListUsecase{
  final PostRepository repository;
  const GetPostListUsecase({required this.repository});

  Future<Either<List<PostEntity>,Failure>> call(){
    return repository.getPosts();
  }
}