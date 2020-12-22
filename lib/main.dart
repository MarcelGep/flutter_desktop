import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/database/auth_helper.dart';
import 'package:flutter_desktop/pages/login_screen.dart';
import 'package:flutter_desktop/pages/settings_page.dart';
import 'package:provider/provider.dart';
import 'helpers/authentication_wrapper.dart';
import 'pages/article_page.dart';
import 'pages/customer_page.dart';
import 'pages/invoice_page.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CustomerMaintenanceApp());
}

class CustomerMaintenanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(
          create: (context) => AuthHelper.authStateChanges,
        ),
      ],
      child: MaterialApp(
        title: 'KundenVerwaltungsApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
        routes: {
          Routes.login: (context) => LoginPage(),
          Routes.customers: (context) => CustomerPage(),
          Routes.invoices: (context) => InvoicePage(),
          Routes.articles: (context) => ArticlePage(),
          Routes.settings: (context) => SettingsPage(),
        },
      ),
    );
  }
}
