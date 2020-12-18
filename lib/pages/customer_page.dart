import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/database/database_helper.dart';
import 'package:flutter_desktop/models/customer.dart';
import 'package:flutter_desktop/widgets/app_drawer.dart';
import 'package:flutter_desktop/widgets/customer_list.dart';

class CustomerPage extends StatelessWidget {
  static const String routeName = '/customers';

  void _addCustomer() {
    var faker = new Faker();
    Customer newCustomer = new Customer(
        null,
        faker.internet.userName(),
        faker.person.name(),
        "Muster Str. 12",
        "89323",
        "Musterstadt",
        "0123456789",
        "0123456789",
        faker.internet.email(),
        "www." + faker.internet.userName() + ".de");

    DatabaseHelper.addCustomer(newCustomer);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Kunden"),
        actions: <Widget>[
          FlatButton(
            onPressed: () => _addCustomer(),
            child: Icon(Icons.add, color: Colors.white),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: CustomerList(),
    );
  }
}
