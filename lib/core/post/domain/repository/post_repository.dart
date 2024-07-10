import 'package:taak_phronesys/core/post/data/mapper/mapper.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';

abstract class PostRepository{
  Mapper mapper = Mapper();
  Future<List<PostEntity>> getPosts();
}