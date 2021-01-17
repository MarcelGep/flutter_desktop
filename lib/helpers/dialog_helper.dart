import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/models/article.dart';
import 'package:flutter_desktop/widgets/TextCounter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../models/customer.dart';
import '../database/database_helper.dart';

class DialogsHelper {
  static void showCustomerDeleteFlushbar(
      BuildContext context, Customer customer, int durationMs) {
    Flushbar<List<String>> flush;
    flush = Flushbar<List<String>>(
      flushbarStyle: FlushbarStyle.GROUNDED,
      showProgressIndicator: false,
      animationDuration: Duration(milliseconds: 500),
      duration: Duration(milliseconds: durationMs),
      shouldIconPulse: false,
      titleText: Text(
        customer.name,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        'wurde gelöscht',
        style: TextStyle(
          color: Colors.red,
          fontSize: 14,
        ),
      ),
      icon: Icon(
        Icons.delete_outline,
        color: Colors.red,
        size: 45,
      ),
      mainButton: FlatButton(
        child: Row(
          children: [
            Icon(Icons.undo, color: Colors.blue, size: 28),
            SizedBox(width: 8),
            CircularPercentIndicator(
              radius: 46.0,
              animation: true,
              animationDuration: durationMs,
              lineWidth: 4.0,
              percent: 1,
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.grey[800],
              progressColor: Colors.blue,
              center: TextCounter(duration: (durationMs / 1000).round()),
            ),
          ],
        ),
        onPressed: () {
          DatabaseHelper.addCustomer(customer);
          flush.dismiss();
        },
      ),
    )..show(context);
  }

  static void showArticleDeleteFlushbar(
      BuildContext context, Article article, int durationMs) {
    Flushbar<List<String>> flush;
    flush = Flushbar<List<String>>(
      flushbarStyle: FlushbarStyle.GROUNDED,
      showProgressIndicator: false,
      animationDuration: Duration(milliseconds: 500),
      duration: Duration(milliseconds: durationMs),
      shouldIconPulse: false,
      titleText: Text(
        article.name,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        'wurde gelöscht',
        style: TextStyle(
          color: Colors.red,
          fontSize: 14,
        ),
      ),
      icon: Icon(
        Icons.delete_outline,
        color: Colors.red,
        size: 45,
      ),
      mainButton: FlatButton(
        child: Row(
          children: [
            Icon(Icons.undo, color: Colors.blue, size: 28),
            SizedBox(width: 8),
            CircularPercentIndicator(
              radius: 46.0,
              animation: true,
              animationDuration: durationMs,
              lineWidth: 4.0,
              percent: 1,
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.grey[800],
              progressColor: Colors.blue,
              center: TextCounter(duration: (durationMs / 1000).round()),
            ),
          ],
        ),
        onPressed: () {
          DatabaseHelper.addArticle(article);
          flush.dismiss();
        },
      ),
    )..show(context);
  }

  static void showErrorFlushbar(
      BuildContext context, String text, int durationMs) {
    Flushbar<List<String>>(
      backgroundColor: Colors.red,
      shouldIconPulse: false,
      duration: Duration(seconds: durationMs),
      messageText: Text(text, style: TextStyle(color: Colors.white)),
      icon: Icon(IconData(0xead6, fontFamily: 'MaterialIcons'),
          color: Colors.white),
    )..show(context);
  }
}
