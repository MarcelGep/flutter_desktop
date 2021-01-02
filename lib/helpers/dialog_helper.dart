import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/pages/customer_edit_page.dart';
import 'package:flutter_desktop/dialogs/customer_info_dialog.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../models/customer.dart';
import '../database/database_helper.dart';

class DialogsHelper {
  static void openCustomerInfoDialog(BuildContext context, Customer customer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomerInfoDialog(customer: customer);
      },
    );
  }

  static void showDeleteFlushbar(BuildContext context, Customer customer) {
    int durationMs = 1500;
    Flushbar<List<String>> flush;
    flush = Flushbar<List<String>>(
      showProgressIndicator: false,
      animationDuration: Duration(milliseconds: 500),
      duration: Duration(milliseconds: durationMs),
      shouldIconPulse: false,
      leftBarIndicatorColor: Colors.red,
      messageText: Text(
        "Kunde wurde gelöscht!",
        style: TextStyle(color: Colors.red),
      ),
      icon: Icon(Icons.delete_outline, color: Colors.red),
      mainButton: FlatButton(
        child: Row(
          children: [
            Text(
              "RÜCKGÄNGIG",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            CircularPercentIndicator(
              radius: 25.0,
              animation: true,
              animationDuration: durationMs,
              lineWidth: 4.0,
              percent: 1,
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.grey[800],
              progressColor: Colors.blue,
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

  static void showErrorFlushbar(BuildContext context, String text) {
    Flushbar<List<String>>(
      backgroundColor: Colors.red,
      shouldIconPulse: false,
      duration: Duration(milliseconds: 1500),
      messageText: Text(text, style: TextStyle(color: Colors.white)),
      icon: Icon(IconData(0xead6, fontFamily: 'MaterialIcons'),
          color: Colors.white),
    )..show(context);
  }
}
