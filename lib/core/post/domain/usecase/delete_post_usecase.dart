import 'package:dartz/dartz.dart';
import 'package:taak_phronesys/core/post/data/datasource/failure.dart';
import 'package:taak_phronesys/core/post/domain/repository/post_repository.dart';

class DeletePostUsecase{
  final PostRepository repository;
  const DeletePostUsecase({required this.repository});

  Future<Either<void,Failure>> call(int postId){
    return repository.deletePost(postId);
  }
}