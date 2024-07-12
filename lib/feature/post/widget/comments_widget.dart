import 'package:flutter/material.dart';
import 'package:taak_phronesys/core/post/domain/entity/comment_entity.dart';

class CommentsWidget extends StatelessWidget {
  const CommentsWidget(this.comments, {super.key});

  final List<CommentEntity> comments;

  _close(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Comments',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    _close(context);
                  },
                  icon: const Icon(Icons.close_outlined, size: 28))
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (ctx, index) => ListTile(
                    title: Text(
                      comments[index].body,
                      softWrap: true,
                    ),
                  )),
        ),
      ],
    );
  }
}
