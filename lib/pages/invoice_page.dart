import 'package:flutter/material.dart';
import 'package:flutter_desktop/widgets/app_drawer.dart';

class InvoicePage extends StatelessWidget {
  static const String routeName = '/invoices';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rechnungen"),
      ),
      drawer: AppDrawer(),
      body: Container(
        alignment: Alignment.center,
        child: Icon(Icons.ac_unit),
      ),
    );
  }
}
