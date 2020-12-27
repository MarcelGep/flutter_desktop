import 'package:flutter/material.dart';
import 'package:flutter_desktop/database/database_helper.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({Key key}) : super(key: key);

  @override
  _UserInfoWidgetState createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  String userName = "";
  String userEmail = "";

  @override
  void initState() {
    DatabaseHelper.getUserData().then((value) {
      setState(() {
        userName = value.name;
        userEmail = value.email;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.green,
            child: Text(userEmail.isNotEmpty
                ? userEmail.characters.first.toUpperCase()
                : ""),
            foregroundColor: Colors.white,
          ),
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (userName != null && userName.isNotEmpty)
              Text(userName, style: TextStyle(fontWeight: FontWeight.w800)),
            if (userEmail != null && userEmail.isNotEmpty) Text(userEmail),
          ],
        ),
      ],
    );
  }
}
