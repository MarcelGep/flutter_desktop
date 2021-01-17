import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/helpers/dialog_helper.dart';
import 'package:flutter_desktop/routes/routes.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:random_color/random_color.dart';

import '../database/database_helper.dart';
import '../models/customer.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // used to keep only one slidable open
    final SlidableController slideController = new SlidableController();
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: StreamBuilder(
        stream: DatabaseHelper.getCustomerStream(),
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
                          child: Text(
                              customer.name.characters.first.toUpperCase()),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          customer.name,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        trailing: PopupMenuButton(
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry>[
                            PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: [
                                  Icon(Icons.create_new_folder,
                                      color: Colors.green),
                                  SizedBox(width: 8),
                                  Text('Rechnung erstellen',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
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
                                Navigator.pushNamed(
                                  context,
                                  Routes.customerDetail,
                                  arguments: customer,
                                );
                                break;
                              case 3:
                                //Delete button
                                DatabaseHelper.deleteCustomer(customer);
                                DialogsHelper.showCustomerDeleteFlushbar(
                                    context, customer, 2000);
                                break;
                            }
                          },
                          icon: Icon(Icons.more_vert),
                        ),
                        subtitle: Text(
                          customer.email,
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.customerDetail,
                            arguments: customer,
                          );
                        },
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
                          Navigator.pushNamed(
                            context,
                            Routes.customerDetail,
                            arguments: customer,
                          );
                        },
                      ),
                      IconSlideAction(
                        caption: 'Löschen',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          DatabaseHelper.deleteCustomer(customer);
                          DialogsHelper.showCustomerDeleteFlushbar(
                              context, customer, 2000);
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
