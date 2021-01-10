import 'package:flutter_desktop/pages/customer_info_page.dart';
import 'package:flutter_desktop/pages/article_page.dart';
import 'package:flutter_desktop/pages/customer_page.dart';
import 'package:flutter_desktop/pages/invoice_page.dart';
import 'package:flutter_desktop/pages/login_screen.dart';
import 'package:flutter_desktop/pages/settings_page.dart';
import 'package:flutter_desktop/pages/signup_screen.dart';

class Routes {
  static const String login = LoginPage.routeName;
  static const String signup = SignUpPage.routeName;
  static const String customers = CustomerPage.routeName;
  static const String invoices = InvoicePage.routeName;
  static const String articles = ArticlePage.routeName;
  static const String settings = SettingsPage.routeName;
  static const String customerInfo = CustomerInfoPage.routeName;
}
