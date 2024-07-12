import 'package:taak_phronesys/core/post/domain/repository/post_repository.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';

class GetPostUsecase{
  final PostRepository repository;
  const GetPostUsecase({required this.repository});

  Future<PostEntity> call(int postId){
    return repository.getPost(postId);
  }
}