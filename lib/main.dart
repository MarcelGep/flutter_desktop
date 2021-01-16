import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/database/auth_helper.dart';
import 'package:flutter_desktop/pages/article_detail_page.dart';
import 'package:flutter_desktop/pages/customer_detail_page.dart';
import 'package:flutter_desktop/pages/login_screen.dart';
import 'package:flutter_desktop/pages/settings_page.dart';
import 'package:flutter_desktop/pages/signup_screen.dart';
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
        showPerformanceOverlay: false,
        title: 'KundenVerwaltungsApp',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
        routes: {
          Routes.login: (context) => LoginPage(),
          Routes.signup: (context) => SignUpPage(),
          Routes.customers: (context) => CustomerPage(),
          Routes.invoices: (context) => InvoicePage(),
          Routes.articles: (context) => ArticlePage(),
          Routes.settings: (context) => SettingsPage(),
          Routes.customerDetail: (context) => CustomerDetailPage(),
          Routes.articleDetail: (context) => ArticleDetailPage(),
        },
      ),
    );
  }
}
