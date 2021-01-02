import 'package:flutter/material.dart';
import 'package:flutter_desktop/routes/routes.dart';
import 'package:flutter_desktop/widgets/app_drawer.dart';
import 'package:flutter_desktop/widgets/customer_list.dart';

class CustomerPage extends StatelessWidget {
  static const String routeName = '/customers';

  // void _addCustomer() {
  //   var faker = new Faker();
  //   Customer newCustomer = new Customer(
  //       null,
  //       faker.internet.userName(),
  //       faker.person.name(),
  //       "Muster Str. 12",
  //       "89323",
  //       "Musterstadt",
  //       "0123456789",
  //       "0123456789",
  //       faker.internet.email(),
  //       "www." + faker.internet.userName() + ".de");

  //   DatabaseHelper.addCustomer(newCustomer);
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Kunden", style: TextStyle(color: Colors.black87)),
        actions: <Widget>[
          FlatButton(
            onPressed: () =>
                //_addCustomer(),
                Navigator.pushNamed(context, Routes.customerEdit,
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
