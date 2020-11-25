import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
          child: MyHomePage(title: 'Flutter Desktop'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
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
          _createCustomerTab(),
          Icon(Icons.directions_bike),
          Icon(Icons.directions_bike),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

/*   void showDialogBottom() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 300,
            child: SizedBox.expand(child: FlutterLogo()),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
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
  } */

  /* void openAddCustomerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert!'),
          content: Text('Bitte Aktion bestätigen.'),
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
          ],
        );
      },
    );
  } */

  void openCustomerDetailsDialog(String data) {
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
                  width: MediaQuery.of(context).size.width - 500,
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
                        data,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          ListTile(
                            title: Text('Steißlinger Str. 14',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            subtitle: Text('89604 Weilersteußlingen'),
                            leading: Icon(
                              Icons.location_on,
                              color: Colors.blue[500],
                            ),
                          ),
                          Divider(),
                          ListTile(
                            title: Text('07384/1212',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            leading: Icon(
                              Icons.contact_phone,
                              color: Colors.blue[500],
                            ),
                          ),
                          ListTile(
                            title: Text('info@schalltec.tv'),
                            leading: Icon(
                              Icons.contact_mail,
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
                              horizontal: 30, vertical: 10),
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Schließen',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ), // bottom part
                Positioned(
                  left: 20,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 45,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image.asset('images/company.jpg')),
                  ),
                ), // top part
              ],
            ),
          );
        });
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

  Widget _createCustomerTab() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Kundenverwaltung',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              RaisedButton(
                padding: const EdgeInsets.all(15),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {},
                child: Text("Kunde anlegen"),
              ),
              SizedBox(width: 20),
              RaisedButton(
                padding: const EdgeInsets.all(15),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {},
                child: Text("Kunde bearbeiten"),
              ),
              SizedBox(width: 20),
              RaisedButton(
                padding: const EdgeInsets.all(15),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {},
                child: Text("Kunde löschen"),
              )
            ],
          ),
          SizedBox(height: 30),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(100, 0, 0, 0),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: _createCustomerList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createCustomerList() {
    final List<String> entries = <String>[
      'Schalltec GmbH & Co. KG',
      'Max Mustermann',
      'Paul Renschert'
    ];

    return entries.length > 0
        ? ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  tileColor: Colors.grey[350],
                  title: Text(
                    entries[index],
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  onTap: () => openCustomerDetailsDialog(entries[index]),
                ),
              );
            },
          )
        : Center(child: const Text('Keine Einträge'));
  }

/*   Widget _buildCard() => SizedBox(
        height: 210,
        child: Card(
          child: Column(
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
      );*/
}
