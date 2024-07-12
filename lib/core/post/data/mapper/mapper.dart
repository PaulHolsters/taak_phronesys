import 'package:taak_phronesys/core/post/data/dto/comment_dto.dart';
import 'package:taak_phronesys/core/post/data/dto/post_dto.dart';
import 'package:taak_phronesys/core/post/domain/entity/comment_entity.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';

class Mapper{
  mapDTOtoEntity(dynamic dto){
    if(dto is PostDTO){
      return PostEntity(id: dto.id!, title: dto.title!, body: dto.body!, userId: dto.userId!);
    } else if(dto is CommentDTO){
      return CommentEntity(id: dto.id!, name: dto.name!, email: dto.email!, body: dto.body!, postId: dto.postId!);
    }
  }
  mapEntityToDTO(dynamic ent){
    if(ent is PostEntity){
      return PostDTO(id: ent.id, title: ent.title, body: ent.body, userId: ent.userId);
    }
  }
}