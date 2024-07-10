// de controller wordt in deze widget aangemaakt
// de controller staat in voor het halen en doorgeven van data
import 'package:flutter/material.dart';

class PostListPage extends StatelessWidget {
  const PostListPage(this.onSetView,{super.key});

  final void Function(int view) onSetView;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}