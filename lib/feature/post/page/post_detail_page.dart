import 'package:flutter/material.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';
import 'package:taak_phronesys/feature/post/controller/post_detail_controller.dart';
import 'package:taak_phronesys/feature/post/page/active_connection.dart';
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
  bool _isSendingDelete = false;
  bool _isSendingEdit = false;

  @override
  void initState() {
    pdc = PostDetailsController();
    // geen internet => snackbar ipv getPost
    _getPost();
    super.initState();
  }

  _getPost() async {
    final hasConnection = await ActiveConnection.hasConnection();
    if (hasConnection) {
      final temp = await pdc!.getPost(widget.postId);
      temp.fold((l) {
        setState(() {
          _post = l;
        });
      }, (r) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: Colors.red, content: Text(r.message)));
      });
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
              'Check your internet connection. Then go back to home page and try again.')));
    }
  }

  _deletePost(BuildContext context) async {
    final hasConnection = await ActiveConnection.hasConnection();
    if (hasConnection) {
      setState(() {
        _isSendingDelete = true;
      });
      final res = await pdc!.deletePost(_post!.id);
      res.fold((ifLeft) {
        Navigator.of(context).pop(['delete', ifLeft]);
      }, (ifRight) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red, content: Text(ifRight.message)));
        setState(() {
          _isSendingDelete = false;
        });
      });
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Check your internet connection and try again.')));
    }
  }

  _editPost(BuildContext context) async {
    final hasConnection = await ActiveConnection.hasConnection();
    if (hasConnection) {
      setState(() {
        _isSendingEdit = true;
      });
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        final response = await pdc!.editPost(_post!);
        response.fold((ifLeft) {
          Navigator.of(context).pop(['edit', ifLeft]);
        }, (ifRight) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red, content: Text(ifRight.message)));
          setState(() {
            _isSendingEdit = false;
          });
        });
      }
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Check your internet connection and try again.')));
    }
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
                          decoration:
                              const InputDecoration(label: Text('title')),
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
                          decoration:
                              const InputDecoration(label: Text('body')),
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
                                onPressed: _isSendingEdit
                                    ? null
                                    : () {
                                        _deletePost(context);
                                      },
                                child: _isSendingDelete
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
                                onPressed: _isSendingDelete
                                    ? null
                                    : () {
                                        _editPost(context);
                                      },
                                child: _isSendingEdit
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
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Post details'),
            ),
            body: content));
  }
}
