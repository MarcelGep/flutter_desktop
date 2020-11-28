import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_desktop/main.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      print("Firebase User Email: " + firebaseUser.email);
      return MyHomePage();
    }
    return LoginPage();
  }
}
