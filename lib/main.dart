import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop/customer.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() {
  //debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Desktop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DefaultTabController(
          length: 3,
          child: MyHomePage(title: 'KundenAppFlutter'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Customer> customers = <Customer>[];

  void _addCustomer() {
    setState(() {
      var faker = new Faker();
      customers.add(new Customer(
          faker.internet.userName(),
          faker.person.name(),
          "Muster Str. 12",
          "89323",
          "Musterstadt",
          "0123456789",
          "0123456789",
          faker.internet.email(),
          "www." + faker.internet.userName() + ".de"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          tabs: [
            Tab(
                text: "Kunden",
                icon: Icon(IconData(0xf03e, fontFamily: 'MaterialIcons'))),
            Tab(
                text: "Rechnungen",
                icon: Icon(IconData(0xe5b6, fontFamily: 'MaterialIcons'))),
            Tab(text: "Artikel", icon: Icon(Icons.directions_bike)),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          _createCustomerList(),
          Icon(Icons.directions_bike),
          Icon(Icons.directions_bike),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCustomer,
        tooltip: 'Kunde hinzufügen',
        child: Icon(Icons.add),
      ),
    );
  }

  void showDialogBottom() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.green,
            height: 40,
            child: Text(
              "Änderungen wurden gespeichert.",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            //margin: EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 10),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
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
                                Navigator.of(context).pop();
                                //TODO customer edit
                                //showDialogBottom();
                              },
                              child: Text(
                                'Speichern',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Abbrechen',
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
                        alignment: Alignment.bottomRight,
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Schließen',
                            style: TextStyle(fontSize: 16, color: Colors.white),
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
      child: customers.length > 0
          ? CupertinoScrollbar(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: customers.length,
                itemBuilder: (BuildContext context, int index) {
                  final Customer item = customers[index];
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.indigoAccent,
                          child: Text(item.name.characters.first),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(
                          customers[index].name,
                          style: TextStyle(fontSize: 16, color: Colors.black),
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
                                break;
                              case 2:
                                openEditCustomerDialog(item);
                                break;
                              case 3:
                                setState(() {
                                  customers.remove(item);
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 1),
                                    content:
                                        Text(item.name + " wurde gelöscht"),
                                    action: SnackBarAction(
                                      textColor: Colors.black87,
                                      label: 'Rückgängig',
                                      onPressed: () {
                                        setState(() {
                                          customers.insert(index, item);
                                        });
                                      },
                                    ),
                                  ));
                                });
                                break;
                            }
                            print("value: $value");
                          },
                          icon: Icon(Icons.more_vert),
                        ),
                        subtitle: Text(
                          customers[index].email,
                        ),
                        onTap: () => openShowCustomerDialog(customers[index]),
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
                          openEditCustomerDialog(item);
                        },
                      ),
                      IconSlideAction(
                        caption: 'Löschen',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          setState(() {
                            customers.remove(item);
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 1),
                              content: Text(item.name + " wurde gelöscht"),
                              action: SnackBarAction(
                                textColor: Colors.black87,
                                label: 'Rückgängig',
                                onPressed: () {
                                  setState(() {
                                    customers.insert(index, item);
                                  });
                                },
                              ),
                            ));
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
            )
          : Center(child: const Text('Keine Einträge')),
    );
  }
}

/* return AlertDialog(
          title: Text('Alert!'),
          content: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('1625 Main Street',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text('My City, CA 99984'),
                  leading: Icon(
                    Icons.restaurant_menu,
                    color: Colors.blue[500],
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('(408) 555-1212',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  leading: Icon(
                    Icons.contact_phone,
                    color: Colors.blue[500],
                  ),
                ),
                ListTile(
                  title: Text('costa@example.com'),
                  leading: Icon(
                    Icons.contact_mail,
                    color: Colors.blue[500],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            FlatButton(
              child: Text('Abbrechen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],*/
