import 'package:taak_phronesys/core/post/domain/usecase/get_post_list_usecase.dart';

class PostsController{
  late GetPostListUsecase _usecase;
  
  PostsController({required GetPostListUsecase usecase}){
    _usecase = usecase;
  }

  Future<void> getPosts() async{
    final result = await _usecase.call();
  }
}