import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/database/auth_helper.dart';
import 'package:flutter_desktop/models/customer.dart';
import 'package:flutter_desktop/widgets/customer_list.dart';
import 'package:flutter_desktop/database/database_helper.dart';

import 'login_screen.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('KundenAppFlutter'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                AuthHelper.logOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
              child: Row(
                children: [
                  Icon(Icons.logout, size: 26.0, color: Colors.white),
                  SizedBox(width: 4),
                  Text('LOGOUT', style: TextStyle(color: Colors.white)),
                ],
              ),
            )
          ],
        ),
        body: TabBarView(
          children: [
            CustomerList(),
            Icon(Icons.receipt_sharp),
            Icon(Icons.directions_bike),
            Icon(Icons.settings),
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.react,
          height: 60,
          top: 0,
          items: [
            TabItem(
                icon: IconData(0xf03e, fontFamily: 'MaterialIcons'),
                title: "Kunden"),
            TabItem(
                icon: IconData(0xe5b6, fontFamily: 'MaterialIcons'),
                title: "Rechnungen"),
            TabItem(icon: Icons.directions_bike, title: "Artikel"),
            TabItem(icon: Icons.settings, title: "Einstellungen"),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addCustomer,
          tooltip: 'Kunde hinzufügen',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
