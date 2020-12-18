import 'package:flutter/material.dart';
import 'package:flutter_desktop/widgets/app_drawer.dart';

class ArticlePage extends StatelessWidget {
  static const String routeName = '/articles';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Artikel"),
      ),
      drawer: AppDrawer(),
      body: Container(
        alignment: Alignment.center,
        child: Icon(Icons.ten_k),
      ),
    );
  }
}
