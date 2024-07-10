import 'package:flutter/material.dart';
import 'package:taak_phronesys/core/post/domain/entity/post_entity.dart';
import 'package:taak_phronesys/feature/post/page/post_detail_page.dart';
import 'package:taak_phronesys/feature/post/page/post_list_page.dart';

class PageWrapper extends StatefulWidget {
  const PageWrapper({super.key});

  @override
  State<PageWrapper> createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  int _page = 0;
  PostEntity? _selectedPost;
  _setView(int view){
    setState(() {
      _page = view;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _page == 0 ? const Text('Posts')  : const Text('Post details'),),
      body: _page == 0 ? PostListPage(_setView) : PostDetailPage(_setView,_selectedPost!)
    );
  }
}