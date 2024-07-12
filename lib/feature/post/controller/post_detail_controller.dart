import 'package:taak_phronesys/core/post/data/repository/post_repository_impl.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';
import 'package:taak_phronesys/core/post/domain/usecase/delete_post_usecase.dart';
import 'package:taak_phronesys/core/post/domain/usecase/edit_post_usecase.dart';
import 'package:taak_phronesys/core/post/domain/usecase/get_post_usecase.dart';

class PostDetailsController {
  final GetPostUsecase _getPostUsecase =
      GetPostUsecase(repository: PostRepositoryImpl());
  final EditPostUsecase _editPostUsecase =
      EditPostUsecase(repository: PostRepositoryImpl());
  final DeletePostUsecase _deletePostUsecase =
      DeletePostUsecase(repository: PostRepositoryImpl());

  Future<PostEntity> getPost(int postId) async {
    PostEntity post = await _getPostUsecase.call(postId);
    return post;
  }

  Future<PostEntity> editPost(PostEntity postToEdit) async {
    PostEntity post = await _editPostUsecase.call(postToEdit);
    return post;
  }

  Future<void> deletePost(int postId) async {
    await _deletePostUsecase.call(postId);
  }
}
