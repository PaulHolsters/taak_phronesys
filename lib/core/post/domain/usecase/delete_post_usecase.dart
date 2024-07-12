import 'package:taak_phronesys/core/post/domain/repository/post_repository.dart';

class DeletePostUsecase{
  final PostRepository repository;
  const DeletePostUsecase({required this.repository});

  Future<void> call(int postId){
    return repository.deletePost(postId);
  }
}