import 'package:dartz/dartz.dart';
import 'package:taak_phronesys/core/post/data/datasource/failure.dart';
import 'package:taak_phronesys/core/post/domain/repository/post_repository.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';

class EditPostUsecase{
  final PostRepository repository;
  const EditPostUsecase({required this.repository});

  Future<Either<PostEntity,Failure>> call(PostEntity post){
    return repository.editPost(post);
  }
}