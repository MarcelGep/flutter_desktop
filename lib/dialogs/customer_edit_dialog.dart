import 'package:flutter/material.dart';
import 'package:flutter_desktop/database/database_helper.dart';
import 'package:flutter_desktop/models/customer.dart';

// ignore: must_be_immutable
class CustomerEditDialog extends StatefulWidget {
  Customer customer;
  CustomerEditDialog(this.customer);

  TextEditingController nameController;
  TextEditingController contactController;
  TextEditingController streetController;
  TextEditingController zipController;
  TextEditingController locationController;
  TextEditingController phoneController;
  TextEditingController emailController;
  TextEditingController webController;

  @override
  _CustomerEditDialogState createState() => _CustomerEditDialogState();
}

class _CustomerEditDialogState extends State<CustomerEditDialog> {
  @override
  void initState() {
    super.initState();
    widget.nameController =
        new TextEditingController(text: widget.customer.name);
    widget.contactController =
        new TextEditingController(text: widget.customer.contact);
    widget.streetController =
        new TextEditingController(text: widget.customer.street);
    widget.zipController = new TextEditingController(text: widget.customer.zip);
    widget.locationController =
        new TextEditingController(text: widget.customer.location);
    widget.phoneController =
        new TextEditingController(text: widget.customer.phone);
    widget.emailController =
        new TextEditingController(text: widget.customer.email);
    widget.webController = new TextEditingController(text: widget.customer.web);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 0, top: 35, right: 0, bottom: 10),
            margin: EdgeInsets.only(top: 35),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildName(),
                  SizedBox(height: 15),
                  Column(
                    children: [
                      _buildContact(),
                      _buildStreet(),
                      _buildLocation(),
                      SizedBox(height: 20),
                      Divider(thickness: 1),
                      _buildPhone(),
                      _buildEmail(),
                      _buildWeb(),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildButtons(),
                ],
              ),
            ),
          ),
          _buildTopIcon(),
        ],
      ),
    );
  }

  Widget _buildName() {
    return Container(
      padding: EdgeInsets.only(left: 18, top: 0, right: 18, bottom: 0),
      child: TextField(
        controller: widget.nameController,
        decoration: InputDecoration(
          labelText: 'Firma',
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildContact() {
    return ListTile(
      title: TextField(
        controller: widget.contactController,
        decoration: InputDecoration(labelText: 'Kontakt'),
      ),
      leading: Icon(
        Icons.perm_contact_cal,
        color: Colors.blue[500],
      ),
    );
  }

  Widget _buildStreet() {
    return ListTile(
      title: TextField(
        controller: widget.streetController,
        decoration: InputDecoration(labelText: 'Straße'),
      ),
      leading: Icon(
        Icons.location_on,
        color: Colors.blue[500],
      ),
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: TextField(
                keyboardType: TextInputType.number,
                maxLength: 5,
                decoration: InputDecoration(counterText: '', labelText: 'PLZ'),
                controller: widget.zipController),
            contentPadding:
                EdgeInsets.only(left: 71, top: 0, right: 10, bottom: 0),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 0, top: 0, right: 15, bottom: 0),
            child: TextField(
              controller: widget.locationController,
              decoration: InputDecoration(labelText: 'Ort'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhone() {
    return ListTile(
      title: TextField(
          keyboardType: TextInputType.number,
          maxLength: 15,
          decoration: InputDecoration(counterText: '', labelText: 'Telefon'),
          controller: widget.phoneController),
      leading: Icon(
        Icons.contact_phone,
        color: Colors.blue[500],
      ),
    );
  }

  Widget _buildEmail() {
    return ListTile(
      title: TextField(
        controller: widget.emailController,
        decoration: InputDecoration(labelText: 'E-Mail'),
      ),
      leading: Icon(
        Icons.contact_mail,
        color: Colors.blue[500],
      ),
    );
  }

  Widget _buildWeb() {
    return ListTile(
      title: TextField(
        controller: widget.webController,
        decoration: InputDecoration(labelText: 'Website'),
      ),
      leading: Icon(
        Icons.language,
        color: Colors.blue[500],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            widget.customer.name = widget.nameController.text;
            widget.customer.contact = widget.contactController.text;
            widget.customer.street = widget.streetController.text;
            widget.customer.zip = widget.zipController.text;
            widget.customer.location = widget.locationController.text;
            widget.customer.phone = widget.phoneController.text;
            widget.customer.email = widget.emailController.text;
            widget.customer.web = widget.webController.text;
            DatabaseHelper.updateCustomer(widget.customer);
            Navigator.of(context).pop();
          },
          child: Text(
            'SPEICHERN',
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ),
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'ABBRECHEN',
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ),
      ],
    );
  }

  Widget _buildTopIcon() {
    return Positioned(
      left: 20,
      right: 20,
      child: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(Icons.edit),
        foregroundColor: Colors.white,
        radius: 35,
      ),
    );
  }
}
