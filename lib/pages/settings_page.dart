import 'package:flutter/material.dart';
import 'package:flutter_desktop/widgets/app_drawer.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Einstellungen"),
      ),
      drawer: AppDrawer(),
      body: Container(
        alignment: Alignment.center,
        child: Icon(Icons.settings),
      ),
    );
  }
}
