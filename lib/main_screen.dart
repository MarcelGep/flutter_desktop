import 'package:another_flushbar/flushbar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/auth_helper.dart';
import 'package:flutter_desktop/customer.dart';
import 'package:flutter_desktop/database_helper.dart';
import 'package:flutter_desktop/login_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:random_color/random_color.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _addCustomer() {
    var faker = new Faker();
    Customer newCustomer = new Customer(
        null,
        faker.internet.userName(),
        faker.person.name(),
        "Muster Str. 12",
        "89323",
        "Musterstadt",
        "0123456789",
        "0123456789",
        faker.internet.email(),
        "www." + faker.internet.userName() + ".de");

    DatabaseHelper.addCustomer(newCustomer);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('KundenAppFlutter'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                AuthHelper.logOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
              child: Row(
                children: [
                  Icon(Icons.logout, size: 26.0, color: Colors.white),
                  SizedBox(width: 4),
                  Text('LOGOUT', style: TextStyle(color: Colors.white)),
                ],
              ),
            )
          ],
        ),
        body: TabBarView(
          children: [
            _createCustomerList(),
            Icon(Icons.receipt_sharp),
            Icon(Icons.directions_bike),
            Icon(Icons.settings),
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.react,
          height: 60,
          top: 0,
          items: [
            TabItem(
                icon: IconData(0xf03e, fontFamily: 'MaterialIcons'),
                title: "Kunden"),
            TabItem(
                icon: IconData(0xe5b6, fontFamily: 'MaterialIcons'),
                title: "Rechnungen"),
            TabItem(icon: Icons.directions_bike, title: "Artikel"),
            TabItem(icon: Icons.settings, title: "Einstellungen"),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addCustomer,
          tooltip: 'Kunde hinzufügen',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void openEditCustomerDialog(Customer customer) {
    var nameController = new TextEditingController(text: customer.name);
    var contactController = new TextEditingController(text: customer.contact);
    var streetController = new TextEditingController(text: customer.street);
    var locationController =
        new TextEditingController(text: customer.zip + " " + customer.location);
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
                  width: MediaQuery.of(context).size.width - 50,
                  padding:
                      EdgeInsets.only(left: 20, top: 65, right: 20, bottom: 20),
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
                      children: <Widget>[
                        TextField(
                            controller: nameController,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600)),
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
                              subtitle:
                                  TextField(controller: locationController),
                              leading: Icon(
                                Icons.location_on,
                                color: Colors.blue[500],
                              ),
                            ),
                            SizedBox(height: 10),
                            Divider(thickness: 1),
                            ListTile(
                              title: TextField(controller: phoneController),
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
                                setState(() {
                                  customer.name = nameController.text;
                                  customer.contact = contactController.text;
                                  customer.street = streetController.text;
                                  customer.location = locationController.text;
                                  customer.phone = phoneController.text;
                                  customer.email = emailController.text;
                                  customer.web = webController.text;
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Speichern',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.blue),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Abbrechen',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.blue),
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
                    backgroundColor: Colors.indigoAccent,
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

  void openShowCustomerDialog(Customer customer) {
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
                  width: MediaQuery.of(context).size.width - 50,
                  padding:
                      EdgeInsets.only(left: 20, top: 65, right: 20, bottom: 20),
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
                            style: TextStyle(fontSize: 18, color: Colors.blue),
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

  Widget _createCustomerList() {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        child: CupertinoScrollbar(
          child: StreamBuilder(
            stream: DatabaseHelper.getCustomerStream(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final Customer customer = snapshot.data[index];
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: RandomColor().randomColor(),
                              child: Text(customer.name.characters.first),
                              foregroundColor: Colors.white,
                            ),
                            title: Text(
                              customer.name,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            trailing: PopupMenuButton(
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry>[
                                PopupMenuItem(
                                  value: 1,
                                  child: Row(
                                    children: [
                                      Icon(Icons.create_new_folder,
                                          color: Colors.green),
                                      SizedBox(width: 8),
                                      Text('Rechnung erstellen',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                                PopupMenuDivider(
                                  height: 8,
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, color: Colors.black45),
                                      SizedBox(width: 8),
                                      Text('Bearbeiten'),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 3,
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('Löschen'),
                                    ],
                                  ),
                                ),
                              ],
                              onSelected: (value) {
                                switch (value) {
                                  case 1:
                                    //Invoice button
                                    break;
                                  case 2:
                                    //Edit button
                                    openEditCustomerDialog(customer);
                                    break;
                                  case 3:
                                    //Delete button
                                    DatabaseHelper.deleteCustomer(customer);
                                    showDeleteFlushbar(context, customer);
                                    break;
                                }
                              },
                              icon: Icon(Icons.more_vert),
                            ),
                            subtitle: Text(
                              customer.email,
                            ),
                            onTap: () => openShowCustomerDialog(customer),
                          ),
                        ),
                        actions: <Widget>[
                          IconSlideAction(
                            caption: 'Rechnung',
                            color: Colors.green,
                            icon: Icons.create_new_folder,
                            onTap: () {
                              print('Rechnung erstellen');
                            },
                          ),
                        ],
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Bearbeiten',
                            color: Colors.black45,
                            icon: Icons.edit,
                            onTap: () {
                              openEditCustomerDialog(customer);
                            },
                          ),
                          IconSlideAction(
                            caption: 'Löschen',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {
                              DatabaseHelper.deleteCustomer(customer);
                              showDeleteFlushbar(context, customer);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
            },
          ),
        )
        //: Center(child: const Text('Keine Einträge')),
        );
  }

  void showDeleteFlushbar(BuildContext context, Customer customer) {
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
