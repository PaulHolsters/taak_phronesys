import 'package:taak_phronesys/core/post/data/repository/post_repository_impl.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';
import 'package:taak_phronesys/core/post/domain/usecase/get_post_list_usecase.dart';

class PostsController{

  final GetPostListUsecase _usecase = GetPostListUsecase(repository: PostRepositoryImpl());

  Future<List<PostEntity>> getPosts() async{
   List<PostEntity> posts = await _usecase.call();
   return posts;
  }
}