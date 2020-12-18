import 'package:flutter/material.dart';
import 'package:flutter_desktop/database/auth_helper.dart';
import 'package:flutter_desktop/routes/routes.dart';

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

  Widget _createUserInfos() {
    String userEmail = AuthHelper.getCurrentUser()['email'];
    String userName = AuthHelper.getCurrentUser()['name'];
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.green,
            child: Text(userEmail.characters.first.toUpperCase()),
            foregroundColor: Colors.white,
          ),
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (userName != null && userName.isNotEmpty)
              Text(userName, style: TextStyle(fontWeight: FontWeight.w800)),
            Text(userEmail),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _createHeader(),
          _createUserInfos(),
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
