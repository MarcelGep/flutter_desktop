import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/helpers/dialog_helper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:random_color/random_color.dart';

import '../models/customer.dart';
import '../database/database_helper.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // used to keep only one slidable open
    final SlidableController slideController = new SlidableController();
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: CupertinoScrollbar(
          child: StreamBuilder(
            stream: DatabaseHelper.getCustomerStream(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final Customer customer = snapshot.data[index];
                      return new Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.20,
                        controller: slideController,
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: RandomColor().randomColor(),
                              child: Text(customer.name.characters.first),
                              foregroundColor: Colors.white,
                            ),
                            title: Text(
                              customer.name,
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            trailing: PopupMenuButton(
                              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                                PopupMenuItem(
                                  value: 1,
                                  child: Row(
                                    children: [
                                      Icon(Icons.create_new_folder, color: Colors.green),
                                      SizedBox(width: 8),
                                      Text('Rechnung erstellen', style: TextStyle(fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                                PopupMenuDivider(
                                  height: 8,
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, color: Colors.black45),
                                      SizedBox(width: 8),
                                      Text('Bearbeiten'),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 3,
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
                                    //Invoice button
                                    break;
                                  case 2:
                                    //Edit button
                                    DialogsHelper.openEditCustomerDialog(context, customer);
                                    break;
                                  case 3:
                                    //Delete button
                                    DatabaseHelper.deleteCustomer(customer);
                                    DialogsHelper.showDeleteFlushbar(context, customer);
                                    break;
                                }
                              },
                              icon: Icon(Icons.more_vert),
                            ),
                            subtitle: Text(
                              customer.email,
                            ),
                            onTap: () => DialogsHelper.openCustomerInfoDialog(context, customer),
                          ),
                        ),
                        actions: <Widget>[
                          IconSlideAction(
                            caption: 'Rechnung',
                            color: Colors.green,
                            icon: Icons.create_new_folder,
                            onTap: () {
                              print('Rechnung erstellen');
                            },
                          ),
                        ],
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Bearbeiten',
                            color: Colors.black45,
                            icon: Icons.edit,
                            onTap: () {
                              DialogsHelper.openEditCustomerDialog(context, customer);
                            },
                          ),
                          IconSlideAction(
                            caption: 'Löschen',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {
                              DatabaseHelper.deleteCustomer(customer);
                              DialogsHelper.showDeleteFlushbar(context, customer);
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
        )
        //: Center(child: const Text('Keine Einträge')),
        );
  }
}
