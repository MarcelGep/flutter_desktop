import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/database/database_helper.dart';
import 'package:flutter_desktop/helpers/dialog_helper.dart';
import 'package:flutter_desktop/helpers/formatter.dart';
import 'package:flutter_desktop/models/article.dart';
import 'package:flutter_desktop/routes/routes.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:random_color/random_color.dart';

class ArticleList extends StatelessWidget {
  const ArticleList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // used to keep only one slidable open
    final SlidableController slideController = new SlidableController();
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: StreamBuilder(
        stream: DatabaseHelper.getArticleStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data.length == 0) {
            return Center(
              child: Text('Keine Einträge', style: TextStyle(fontSize: 20)),
            );
          } else {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                padding: const EdgeInsets.only(top: 0, bottom: 30),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final Article article = snapshot.data[index];
                  return new Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.20,
                    controller: slideController,
                    child: Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: RandomColor().randomColor(),
                          child:
                              Text(article.name.characters.first.toUpperCase()),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          article.name,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        trailing: PopupMenuButton(
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry>[
                            PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('Löschen'),
                                ],
                              ),
                            ),
                          ],
                          onSelected: (value) {
                            switch (value) {
                              case 1:
                                //Delete button
                                DatabaseHelper.deleteArticle(article);
                                DialogsHelper.showArticleDeleteFlushbar(
                                    context, article, 2000);
                                break;
                            }
                          },
                          icon: Icon(Icons.more_vert),
                        ),
                        subtitle: Text(
                          Formatter.createCurrencyString(article.price),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.articleDetail,
                            arguments: article,
                          );
                        },
                      ),
                    ),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Löschen',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          DatabaseHelper.deleteArticle(article);
                          DialogsHelper.showArticleDeleteFlushbar(
                              context, article, 2000);
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
