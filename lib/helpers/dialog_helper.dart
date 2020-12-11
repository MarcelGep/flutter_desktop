import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../models/customer.dart';
import '../database/database_helper.dart';

class DialogsHelper {
  static void openEditCustomerDialog(BuildContext context, Customer customer) {
    var nameController = new TextEditingController(text: customer.name);
    var contactController = new TextEditingController(text: customer.contact);
    var streetController = new TextEditingController(text: customer.street);
    var zipController = new TextEditingController(text: customer.zip);
    var locationController = new TextEditingController(text: customer.location);
    var phoneController = new TextEditingController(text: customer.phone);
    var emailController = new TextEditingController(text: customer.email);
    var webController = new TextEditingController(text: customer.web);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.only(left: 0, top: 65, right: 0, bottom: 20),
                  margin: EdgeInsets.only(top: 45),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 10),
                            blurRadius: 10),
                      ]),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 18, top: 0, right: 18, bottom: 5),
                          child: TextField(
                            controller: nameController,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            ListTile(
                              title: TextField(controller: contactController),
                              leading: Icon(
                                Icons.perm_contact_cal,
                                color: Colors.blue[500],
                              ),
                            ),
                            ListTile(
                              title: TextField(controller: streetController),
                              leading: Icon(
                                Icons.location_on,
                                color: Colors.blue[500],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: TextField(
                                        keyboardType: TextInputType.number,
                                        maxLength: 5,
                                        decoration:
                                            InputDecoration(counterText: ""),
                                        controller: zipController),
                                    contentPadding: EdgeInsets.only(
                                        left: 71, top: 0, right: 10, bottom: 0),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 0, top: 0, right: 15, bottom: 0),
                                    child: TextField(
                                        controller: locationController),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Divider(thickness: 1),
                            ListTile(
                              title: TextField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 15,
                                  decoration: InputDecoration(counterText: ""),
                                  controller: phoneController),
                              leading: Icon(
                                Icons.contact_phone,
                                color: Colors.blue[500],
                              ),
                            ),
                            ListTile(
                              title: TextField(controller: emailController),
                              leading: Icon(
                                Icons.contact_mail,
                                color: Colors.blue[500],
                              ),
                            ),
                            ListTile(
                              title: TextField(controller: webController),
                              leading: Icon(
                                Icons.language,
                                color: Colors.blue[500],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                customer.name = nameController.text;
                                customer.contact = contactController.text;
                                customer.street = streetController.text;
                                customer.zip = zipController.text;
                                customer.location = locationController.text;
                                customer.phone = phoneController.text;
                                customer.email = emailController.text;
                                customer.web = webController.text;
                                DatabaseHelper.updateCustomer(customer);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'SPEICHERN',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'ABBRECHEN',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.edit),
                    foregroundColor: Colors.white,
                    radius: 45,
                  ),
                ),
              ],
            ),
          );
        });
  }

  static void openShowCustomerDialog(BuildContext context, Customer customer) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.only(left: 0, top: 65, right: 0, bottom: 20),
                  margin: EdgeInsets.only(top: 45),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 10),
                            blurRadius: 10),
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        customer.name,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          ListTile(
                            title: Text(customer.contact,
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            leading: Icon(
                              Icons.perm_contact_cal,
                              color: Colors.blue[500],
                            ),
                          ),
                          ListTile(
                            title: Text(customer.street,
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            subtitle:
                                Text(customer.zip + " " + customer.location),
                            leading: Icon(
                              Icons.location_on,
                              color: Colors.blue[500],
                            ),
                          ),
                          Divider(thickness: 1),
                          ListTile(
                            title: Text(customer.phone),
                            leading: Icon(
                              Icons.contact_phone,
                              color: Colors.blue[500],
                            ),
                          ),
                          ListTile(
                            title: Text(customer.email),
                            leading: Icon(
                              Icons.contact_mail,
                              color: Colors.blue[500],
                            ),
                          ),
                          ListTile(
                            title: Text(customer.web),
                            leading: Icon(
                              Icons.language,
                              color: Colors.blue[500],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'ZURÜCK',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image.asset('images/company.jpg'),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
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
}
