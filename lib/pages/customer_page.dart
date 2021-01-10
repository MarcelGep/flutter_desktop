import 'package:flutter/material.dart';
import 'package:flutter_desktop/database/database_helper.dart';
import 'package:flutter_desktop/routes/routes.dart';
import 'package:flutter_desktop/widgets/app_drawer.dart';
import 'package:flutter_desktop/widgets/customer_list.dart';

class CustomerPage extends StatefulWidget {
  static const String routeName = '/customers';

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey[850]),
        title: Text("Kunden", style: TextStyle(color: Colors.grey[850])),
        actions: <Widget>[
          FlatButton(
            onPressed: () => DatabaseHelper.addRandomCustomer(),
            child: Icon(Icons.add_box, color: Colors.grey[850]),
          ),
          FlatButton(
            onPressed: () => Navigator.pushNamed(context, Routes.customerInfo,
                arguments: null),
            child: Icon(Icons.add, color: Colors.grey[850]),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: CustomerList(),
    );
  }
}
