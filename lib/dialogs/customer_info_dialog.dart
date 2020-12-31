import 'package:flutter/material.dart';
import 'package:flutter_desktop/models/customer.dart';

// ignore: must_be_immutable
class CustomerInfoDialog extends StatefulWidget {
  Customer customer;
  CustomerInfoDialog({Key key, this.customer}) : super(key: key);

  @override
  _CustomerInfoDialogState createState() => _CustomerInfoDialogState();
}

class _CustomerInfoDialogState extends State<CustomerInfoDialog> {
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
            padding: EdgeInsets.only(left: 0, top: 65, right: 0, bottom: 10),
            margin: EdgeInsets.only(top: 45),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10)
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildName(),
                SizedBox(height: 20),
                Column(
                  children: [
                    _buildContact(),
                    _buildLocation(),
                    Divider(thickness: 1),
                    _buildPhone(),
                    _buildFax(),
                    _buildEmail(),
                    _buildWeb(),
                  ],
                ),
                SizedBox(height: 22),
                _buildButton(context),
              ],
            ),
          ),
          _buildTopIcon(),
        ],
      ),
    );
  }

  Widget _buildName() {
    return Text(
      widget.customer.name,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildContact() {
    return ListTile(
      title: Text(widget.customer.contact),
      leading: Icon(
        Icons.perm_contact_cal,
        color: Colors.blue[500],
      ),
    );
  }

  Widget _buildLocation() {
    return ListTile(
      title: Text(widget.customer.street),
      subtitle: Text(widget.customer.zip + " " + widget.customer.location),
      leading: Icon(
        Icons.location_on,
        color: Colors.blue[500],
      ),
    );
  }

  Widget _buildPhone() {
    return ListTile(
      title: Text(widget.customer.phone),
      leading: Icon(
        Icons.contact_phone,
        color: Colors.blue[500],
      ),
    );
  }

  Widget _buildFax() {
    return ListTile(
      title: Text(widget.customer.fax),
      leading: Icon(
        Icons.contact_phone,
        color: Colors.blue[500],
      ),
    );
  }

  Widget _buildEmail() {
    return ListTile(
      title: Text(widget.customer.email),
      leading: Icon(
        Icons.contact_mail,
        color: Colors.blue[500],
      ),
    );
  }

  Widget _buildWeb() {
    return ListTile(
      title: Text(widget.customer.web),
      leading: Icon(
        Icons.language,
        color: Colors.blue[500],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          'ZURÜCK',
          style: TextStyle(fontSize: 16, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildTopIcon() {
    return Positioned(
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
    );
  }
}
