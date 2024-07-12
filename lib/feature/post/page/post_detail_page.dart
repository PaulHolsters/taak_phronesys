import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';
import 'package:taak_phronesys/feature/post/controller/post_detail_controller.dart';
import 'package:taak_phronesys/feature/post/widget/comments_widget.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage(this.postId, {super.key});
  final int postId;

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final _formKey = GlobalKey<FormState>();
  PostDetailsController? pdc;
  PostEntity? _post;
  bool _isSending = false;
  _deletePost() {
    setState(() {
      _isSending = true;
    });
  }

  _editPost() {
    setState(() {
      _isSending = true;
    });
  }

  @override
  void initState() {
    pdc = PostDetailsController();
    _getPost();
    super.initState();
  }

  _getPost() async {
    final temp = await pdc!.getPost(widget.postId);
    setState(() {
      _post = temp;
    });
  }

  _openComments(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => CommentsWidget(_post!.comments!),
        constraints: BoxConstraints(
            minWidth: double.infinity,
            minHeight: (MediaQuery.sizeOf(context).height) * (4.2 / 7.2),
            maxHeight: (MediaQuery.sizeOf(context).height) * (4.2 / 7.2)),
        shape: const Border(),
        isScrollControlled: true,
        useSafeArea: true);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: CircularProgressIndicator());
    if (_post != null) {
      String comment = 'This post has no comments yet.';
      if (_post!.comments!.isNotEmpty) comment = _post!.comments![0].body;
      content = OverflowBox(
        maxHeight: double.infinity,
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(label: Text('title')),
                          initialValue: _post!.title,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length <= 1) {
                              return 'Give the title of the post an appropriate length.';
                            }
                            return null;
                          },
                          maxLines: 2,
                          onSaved: (value) {
                            _post!.title = value!;
                          },
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(label: Text('body')),
                          initialValue: _post!.body,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length <= 1) {
                              return 'Give the body of the post an appropriate length.';
                            }
                            return null;
                          },
                          maxLines: 6,
                          onSaved: (value) {
                            _post!.body = value!;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all(Colors.red)),
                                onPressed: _isSending ? null : _deletePost,
                                child: _isSending
                                    ? const SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator())
                                    : const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      )),
                            const SizedBox(
                              width: 12,
                            ),
                            ElevatedButton(
                                onPressed: _isSending ? null : _editPost,
                                child: _isSending
                                    ? const SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator())
                                    : const Text('Edit'))
                          ],
                        ),
                      ],
                    )),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Comments ${_post!.comments!.length}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: _post!.comments == null
                            ? null
                            : () {
                                _openComments(context);
                              },
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(comment),
                        )),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Post details'),
        ),
        body: content);
  }
}
