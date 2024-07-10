import 'package:taak_phronesys/core/post/domain/repository/post_repository.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';

class GetPostListUsecase{
  final PostRepository repository;
  const GetPostListUsecase({required this.repository});

  Future<List<PostEntity>> call(){
    return repository.getPosts();
  }
}