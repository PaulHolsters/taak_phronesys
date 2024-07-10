import 'package:taak_phronesys/core/post/data/dto/post_dto.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';

class Mapper{
  mapDTOtoEntity(dynamic dto){
    if(dto is PostDTO){
      return PostEntity(id: dto.id!, title: dto.title!, body: dto.body!, userId: dto.userId!);
    }
  }
}