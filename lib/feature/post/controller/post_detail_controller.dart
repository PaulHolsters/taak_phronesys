import 'package:dartz/dartz.dart';
import 'package:taak_phronesys/core/post/data/datasource/failure.dart';
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

  Future<Either<PostEntity,Failure>> getPost(int postId) async {
    return await _getPostUsecase.call(postId);
  }

  Future<Either<PostEntity,Failure>> editPost(PostEntity postToEdit) async {
    return await _editPostUsecase.call(postToEdit);
  }

  Future<Either<void,Failure>> deletePost(int postId) async {
    return await _deletePostUsecase.call(postId);
  }
}
