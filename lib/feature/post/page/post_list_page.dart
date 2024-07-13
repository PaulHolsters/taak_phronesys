import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taak_phronesys/core/post/data/datasource/post_datasource.dart';
import 'package:taak_phronesys/core/post/data/repository/post_repository_impl.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';
import 'package:taak_phronesys/core/post/domain/usecase/get_post_list_usecase.dart';
import 'package:taak_phronesys/feature/post/controller/post_list_controller.dart';
import 'package:taak_phronesys/feature/post/page/post_detail_page.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  PostsController? pc;
  List<PostEntity>? posts;

  _setView(BuildContext context, int postId, int index) async {
    var response = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => PostDetailPage(postId)));
    // the purpose of the following is to gain performance by altering the posts list before actually fetching the updated let from the server
    if(response[0]=='delete'){
      var post = posts!.firstWhere((p)=>p.id==response[1].id);
      setState(() {
        posts!.remove(post);
      });
    } else{
      // todo fix replacement
      var post = posts!.firstWhere((p)=>p.id==response[1].id);
      posts!.remove(post);
      PostEntity p = response[1];
      setState(() {
        posts!.insert(index, p);
      });
    }   
    _fetchPosts();
  }

  _fetchPosts() async {
    final temp = await pc!.getPosts();
    setState(() {
      posts = temp.toList();
    });
  }

  @override
  void initState() {
    pc = PostsController();
    _getPosts();
    super.initState();
  }

  _getPosts() async {
    final temp = await pc!.getPosts();
    setState(() {
      posts = temp.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: CircularProgressIndicator());
    if (posts != null) {
      content = RefreshIndicator(
        onRefresh: () async{
          _fetchPosts();
        },
        child: ListView.builder(
            itemCount: posts!.length,
            itemBuilder: (ctx, index) => ListTile(
                  title: Text(
                    posts![index].title,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    _setView(context, posts![index].id,index);
                  },
                )),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
        ),
        body: content);
  }
}
