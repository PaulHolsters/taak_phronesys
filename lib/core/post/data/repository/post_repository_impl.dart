import 'package:taak_phronesys/core/post/data/datasource/comment_datasource.dart';
import 'package:taak_phronesys/core/post/data/datasource/post_datasource.dart';
import 'package:taak_phronesys/core/post/data/dto/comment_dto.dart';
import 'package:taak_phronesys/core/post/data/dto/post_dto.dart';
import 'package:taak_phronesys/core/post/domain/entity/comment_entity.dart';
import 'package:taak_phronesys/core/post/domain/repository/post_repository.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';

class PostRepositoryImpl extends PostRepository {
  // is dit 1/1 de PostRepository qua acties? da's de bedoeling ja 
  // hier gebeurt ook de omzetting van DTO=>entity
  // 
  final PostDataSource _postDataSource = PostDataSource();
  final CommentDataSource _commentDataSource = CommentDataSource();

  @override
  Future<PostEntity> getPost(int postId) async {
    try {
      PostDTO postsDTO = await _postDataSource.getPost(postId);
      List<CommentDTO> commentDTOs = await _commentDataSource.getComments(postId);
      PostEntity post = mapper.mapDTOtoEntity(postsDTO);
      List<CommentEntity> comments = [];
      for (final item in commentDTOs){
        comments.add(mapper.mapDTOtoEntity(item));
      }
      post.comments = comments;
      return post;
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<PostEntity> editPost(PostEntity post) async {
    try {
      PostDTO postsDTO = await _postDataSource.editPost(mapper.mapEntityToDTO(post));
      return mapper.mapDTOtoEntity(postsDTO);
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deletePost(int postId) async {
    try {
      await _postDataSource.deletePost(postId);
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PostEntity>> getPosts() async {
    try {
      List<PostDTO> postsDTO = await _postDataSource.getPosts();
      List<PostEntity> posts = [];
      for (final item in postsDTO) {
        posts.add(mapper.mapDTOtoEntity(item));
      }
      return posts;
    } on Exception catch (e) {
      rethrow;
    }
  }
}
