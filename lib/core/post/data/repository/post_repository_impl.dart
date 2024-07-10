import 'package:taak_phronesys/core/post/data/datasource/post_datasource.dart';
import 'package:taak_phronesys/core/post/data/dto/post_dto.dart';
import 'package:taak_phronesys/core/post/domain/repository/post_repository.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';

class PostRepositoryImpl extends PostRepository{
  late PostDataSource _datasource;

  PostRepositoryImpl({required PostDataSource postDataSource}){
    _datasource = postDataSource;
  }

  @override
  Future<List<PostEntity>> getPosts() async{
    try{
      List<PostDTO> postsDTO = await _datasource.getPosts();
      List<PostEntity> posts = [];
      for (final item in postsDTO){
        posts.add(mapper.mapDTOtoEntity(item));
      }
      return posts;
    } on Exception catch(e){
      rethrow;
    }
  
  }
}