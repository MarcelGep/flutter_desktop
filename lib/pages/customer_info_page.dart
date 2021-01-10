import 'package:flutter/material.dart';
import 'package:flutter_desktop/database/database_helper.dart';
import 'package:flutter_desktop/models/customer.dart';

// ignore: must_be_immutable
class CustomerInfoPage extends StatefulWidget {
  static const String routeName = '/customerInfoPage';

  TextEditingController nameController;
  TextEditingController contactController;
  TextEditingController streetController;
  TextEditingController zipController;
  TextEditingController locationController;
  TextEditingController phoneController;
  TextEditingController faxController;
  TextEditingController emailController;
  TextEditingController webController;

  @override
  _CustomerInfoPageState createState() => _CustomerInfoPageState();
}

class _CustomerInfoPageState extends State<CustomerInfoPage> {
  final _formKeyName = GlobalKey<FormState>();
  final _formKeyPhone = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormState>();

  bool _validated = true;
  bool _editCustomer = false;
  Customer _customer;

  void initCustomerData() {
    _customer = ModalRoute.of(context).settings.arguments;

    if (_customer != null) {
      _editCustomer = true;
    } else {
      _customer = new Customer.emptyCustomer();
    }

    widget.nameController = new TextEditingController(text: _customer.name);
    widget.contactController =
        new TextEditingController(text: _customer.contact);
    widget.streetController = new TextEditingController(text: _customer.street);
    widget.zipController = new TextEditingController(text: _customer.zip);
    widget.locationController =
        new TextEditingController(text: _customer.location);
    widget.phoneController = new TextEditingController(text: _customer.phone);
    widget.faxController = new TextEditingController(text: _customer.fax);
    widget.emailController = new TextEditingController(text: _customer.email);
    widget.webController = new TextEditingController(text: _customer.web);
  }

  @override
  Widget build(BuildContext context) {
    initCustomerData();
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 123,
        leading: FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios, size: 24, color: Colors.grey[850]),
              Text(
                'Kunden',
                style: TextStyle(fontSize: 18, color: Colors.grey[850]),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () => applyCustomer(),
            child: Text(
              _editCustomer ? 'Speichern' : 'Erstellen',
              style: TextStyle(color: Colors.grey[850], fontSize: 18),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.lightBlue),
            child: Column(children: [
              Icon(Icons.person, size: 100, color: Colors.white),
              SizedBox(height: 5),
              Text(widget.nameController.text,
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(height: 15),
            ]),
          ),
          Container(
            child: Expanded(
              child: ListView(
                children: [
                  _createSpaceBox(),
                  _createContactCard(
                    Column(
                      children: [
                        _buildCompany(),
                        _buildContact(),
                        _buildLocation(),
                      ],
                    ),
                  ),
                  _createSpaceBox(),
                  _createContactCard(
                    Column(
                      children: [
                        _buildPhone(),
                      ],
                    ),
                  ),
                  _createSpaceBox(),
                  _createContactCard(
                    Column(
                      children: [
                        _buildEmail(),
                        _buildWeb(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompany() {
    return Form(
      key: _formKeyName,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 30),
        child: Row(
          children: [
            Icon(Icons.home_work, color: Colors.blue),
            SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                controller: widget.nameController,
                decoration: InputDecoration(
                  labelText: 'Firma',
                  labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                style: TextStyle(fontWeight: FontWeight.w600),
                onChanged: (value) => _formKeyName.currentState.validate(),
                validator: (value) {
                  if (value.isEmpty) {
                    _validated = false;
                    return 'Eingabe erforderlich';
                  }
                  _validated = true;
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContact() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 30),
      child: Row(
        children: [
          Icon(Icons.perm_contact_cal, color: Colors.blue[500]),
          SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.streetAddress,
              controller: widget.contactController,
              decoration: InputDecoration(labelText: 'Kontakt'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 30),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.blue[500]),
              SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  controller: widget.streetController,
                  decoration: InputDecoration(labelText: 'Straße'),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 45),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  decoration:
                      InputDecoration(counterText: '', labelText: 'PLZ'),
                  controller: widget.zipController,
                ),
              ),
              SizedBox(width: 30),
              Expanded(
                flex: 3,
                child: TextFormField(
                  controller: widget.locationController,
                  decoration: InputDecoration(labelText: 'Ort'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhone() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 30),
      child: Form(
        key: _formKeyPhone,
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.contact_phone, color: Colors.blue[500]),
                SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    maxLength: 15,
                    decoration:
                        InputDecoration(counterText: '', labelText: 'Telefon'),
                    controller: widget.phoneController,
                    onChanged: (value) => _formKeyPhone.currentState.validate(),
                    validator: (value) {
                      if (value.isEmpty) {
                        _validated = false;
                        return 'Eingabe erforderlich';
                      }
                      _validated = true;
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 45),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    maxLength: 15,
                    controller: widget.faxController,
                    decoration:
                        InputDecoration(counterText: '', labelText: 'Fax'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 30),
      child: Form(
        key: _formKeyEmail,
        child: Row(
          children: [
            Icon(Icons.contact_mail, color: Colors.blue[500]),
            SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: widget.emailController,
                decoration: InputDecoration(labelText: 'E-Mail'),
                onTap: () => _formKeyEmail.currentState.reset(),
                validator: (value) {
                  if (value.isEmpty) {
                    _validated = false;
                    return 'Eingabe ist erforderlich';
                  } else if (!isEmail(value)) {
                    _validated = false;
                    return 'Ungültige E-Mail Adresse';
                  }
                  _validated = true;
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeb() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 30),
      child: Row(
        children: [
          Icon(
            Icons.language,
            color: Colors.blue[500],
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.url,
              controller: widget.webController,
              decoration: InputDecoration(labelText: 'Website'),
            ),
          ),
        ],
      ),
    );
  }

  void applyCustomer() {
    if (_formKeyName.currentState.validate() &&
        _formKeyPhone.currentState.validate() &&
        _formKeyEmail.currentState.validate() &&
        _validated) {
      _customer.name = widget.nameController.text;
      _customer.contact = widget.contactController.text;
      _customer.street = widget.streetController.text;
      _customer.zip = widget.zipController.text;
      _customer.location = widget.locationController.text;
      _customer.phone = widget.phoneController.text;
      _customer.fax = widget.faxController.text;
      _customer.email = widget.emailController.text;
      _customer.web = widget.webController.text;

      if (_editCustomer) {
        DatabaseHelper.updateCustomer(_customer);
      } else {
        DatabaseHelper.addCustomer(_customer);
      }
      Navigator.pop(context);
    }
  }

  bool isEmail(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }

  Widget _createSpaceBox() {
    return SizedBox(height: 10);
  }

  Widget _createContactCard(Widget child) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      elevation: 2,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Padding(
        padding: EdgeInsets.only(top: 5, bottom: 25),
        child: child,
      ),
    );
  }
}
