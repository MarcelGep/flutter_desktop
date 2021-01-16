import 'package:flutter/material.dart';
import 'package:flutter_desktop/database/database_helper.dart';
import 'package:flutter_desktop/routes/routes.dart';
import 'package:flutter_desktop/widgets/app_drawer.dart';
import 'package:flutter_desktop/widgets/article_list.dart';

class ArticlePage extends StatefulWidget {
  static const String routeName = '/articles';

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey[850]),
        title: Text("Artikel", style: TextStyle(color: Colors.grey[850])),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pushNamed(context, Routes.articleDetail,
                arguments: null),
            child: Icon(Icons.add, color: Colors.grey[850]),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ArticleList(),
    );
  }
}
