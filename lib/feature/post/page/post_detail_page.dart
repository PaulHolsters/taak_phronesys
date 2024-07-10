import 'package:flutter/material.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage(this.onSetView,this.selectedPost,{super.key});

  final void Function(int view) onSetView;
  final PostEntity selectedPost;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}