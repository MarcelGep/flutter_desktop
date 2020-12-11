import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/auth_helper.dart';
import 'package:provider/provider.dart';
import 'authentication_wrapper.dart';

void main() async {
  //Activate for Windows Application
  //debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(
          create: (context) => AuthHelper.authStateChanges,
        ),
      ],
      child: MaterialApp(
        title: 'KundenAppFlutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}
