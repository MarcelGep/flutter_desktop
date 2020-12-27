import 'package:flutter/material.dart';
import 'package:flutter_desktop/database/auth_helper.dart';
import 'package:flutter_desktop/routes/routes.dart';

import 'user_info_widget.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon, color: Colors.blue, size: 30),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage('images/customerBannerShort.jpg'),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 8.0,
            left: 16.0,
            child: Text(
              "KundenVerwaltungsApp",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 23.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _createHeader(),
          UserInfoWidget(),
          Divider(),
          _createDrawerItem(
            icon: IconData(0xf03e, fontFamily: 'MaterialIcons'),
            text: 'Kunden',
            onTap: () =>
                Navigator.pushReplacementNamed(context, Routes.customers),
          ),
          _createDrawerItem(
            icon: IconData(0xe5b6, fontFamily: 'MaterialIcons'),
            text: 'Rechnungen',
            onTap: () =>
                Navigator.pushReplacementNamed(context, Routes.invoices),
          ),
          _createDrawerItem(
            icon: Icons.set_meal,
            text: 'Artikel',
            onTap: () =>
                Navigator.pushReplacementNamed(context, Routes.articles),
          ),
          _createDrawerItem(
            icon: Icons.settings,
            text: 'Einstellungen',
            onTap: () =>
                Navigator.pushReplacementNamed(context, Routes.settings),
          ),
          Divider(),
          _createDrawerItem(
            icon: Icons.logout,
            text: 'Ausloggen',
            onTap: () {
              AuthHelper.logOut();
              Navigator.pushReplacementNamed(context, Routes.login);
            },
          ),
        ],
      ),
    );
  }
}
