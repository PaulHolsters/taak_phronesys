import 'package:async/async.dart';
import 'package:dartz/dartz.dart';
import 'package:taak_phronesys/core/post/data/datasource/comment_datasource.dart';
import 'package:taak_phronesys/core/post/data/datasource/failure.dart';
import 'package:taak_phronesys/core/post/data/datasource/post_datasource.dart';
import 'package:taak_phronesys/core/post/data/dto/comment_dto.dart';
import 'package:taak_phronesys/core/post/data/dto/post_dto.dart';
import 'package:taak_phronesys/core/post/domain/entity/comment_entity.dart';
import 'package:taak_phronesys/core/post/domain/repository/post_repository.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';

class PostRepositoryImpl extends PostRepository {
  final PostDataSource _postDataSource = PostDataSource();
  final CommentDataSource _commentDataSource = CommentDataSource();

  @override
  Future<Either<PostEntity, Failure>> getPost(int postId) async {
    try {
      FutureGroup futureGroup = FutureGroup();
      final getPost = _postDataSource.getPost(postId);
      final getComments = _commentDataSource.getComments(postId);
      futureGroup.add(getPost);
      futureGroup.add(getComments);
      futureGroup.close();
      final onValue = await futureGroup.future;
      Either<PostDTO, Failure> resPostsDTO = onValue[0];
      Either<List<CommentDTO>, Failure> resCommentDTOs = onValue[1];
      PostEntity? post;
      resPostsDTO.fold((ifLeft) {
        post = mapper.mapDTOtoEntity(ifLeft);
      }, (ifRight) {
        return Right(ifRight);
      });
      List<CommentEntity>? comments;
      return resCommentDTOs.fold((ifLeft) {
        comments = [];
        for (final item in ifLeft) {
          comments!.add(mapper.mapDTOtoEntity(item));
        }
        post!.comments = comments;
        return Left(post!);
      }, (ifRight) {
        return Right(ifRight);
      });
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<PostEntity, Failure>> editPost(PostEntity post) async {
    try {
      Either<PostDTO, Failure> postDTORes =
          await _postDataSource.editPost(mapper.mapEntityToDTO(post));
      return postDTORes.fold((ifLeft) {
        return Left(mapper.mapDTOtoEntity(ifLeft));
      }, (ifRight) {
        return Right(ifRight);
      });
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<void, Failure>> deletePost(int postId) async {
    try {
      return await _postDataSource.deletePost(postId);
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<List<PostEntity>, Failure>> getPosts() async {
    try {
      Either<List<PostDTO>, Failure> postDTORes =
          await _postDataSource.getPosts();
      return postDTORes.fold((ifLeft) {
        List<PostEntity> posts = [];
        for (final item in ifLeft) {
          posts.add(mapper.mapDTOtoEntity(item));
        }
        return Left(posts);
      }, (ifRight) {
        return Right(ifRight);
      });
    } on Exception catch (e) {
      rethrow;
    }
  }
}
