import 'package:flutter/material.dart';
import 'package:flutter_desktop/database/database_helper.dart';
import 'package:flutter_desktop/routes/routes.dart';
import 'package:flutter_desktop/widgets/app_drawer.dart';
import 'package:flutter_desktop/widgets/customer_list.dart';

class CustomerPage extends StatelessWidget {
  static const String routeName = '/customers';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Kunden", style: TextStyle(color: Colors.black87)),
        actions: <Widget>[
          FlatButton(
            onPressed: () => DatabaseHelper.addRandomCustomer(),
            child: Icon(Icons.add_box, color: Colors.black87),
          ),
          FlatButton(
            onPressed: () => Navigator.pushNamed(context, Routes.customerEdit,
                arguments: null),
            child: Icon(Icons.add, color: Colors.black87),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: CustomerList(),
    );
  }
}
