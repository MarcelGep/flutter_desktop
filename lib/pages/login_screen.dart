import 'package:flutter/material.dart';
import 'package:flutter_desktop/database/auth_helper.dart';
import 'package:flutter_desktop/database/database_helper.dart';
import 'package:flutter_desktop/helpers/dialog_helper.dart';
import 'package:flutter_desktop/routes/routes.dart';
import 'package:flutter_desktop/widgets/bezier_container.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signup_screen.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: "");
    passwordController = TextEditingController(text: "");
  }

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 50.0,
      buttonColor: Colors.orange[600],
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Builder(
        builder: (context) => RaisedButton(
            child: Text(
              'Login',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () async {
              try {
                await AuthHelper.signInWithEmail(
                    email: emailController.text,
                    password: passwordController.text);
                Navigator.pushReplacementNamed(context, Routes.customers);
              } catch (e) {
                print(e);
                String errorMessage = e.toString();
                if (errorMessage.contains('wrong-password'))
                  errorMessage = "Falsches Password!";
                if (errorMessage.contains('invalid-email'))
                  errorMessage = "Ungültige E-Mail Adresse!";
                if (errorMessage.contains('unknown'))
                  errorMessage = "Unbekannter Fehler!";
                if (errorMessage.contains('user-not-found'))
                  errorMessage = "Benutzer wurde nicht gefunden!";

                DialogsHelper.showErrorFlushbar(context, errorMessage);
              }
            }),
      ),
    );
  }

  Widget _googleButton() {
    return RaisedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage('images/google-logo.png'),
            height: 50,
          ),
          Text(
            'Login mit Google',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
        ],
      ),
      onPressed: () {
        AuthHelper.signInWithGoogle().then((result) {
          if (result != null) {
            DatabaseHelper.addUserData(null);
            Navigator.pushReplacementNamed(context, Routes.customers);
          }
        });
      },
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Noch kein Account vorhanden?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Registrieren',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Kunden',
          style: GoogleFonts.portLligatSans(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'Verwaltung',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("E-Mail", emailController),
        _entryField("Passwort", passwordController, isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: -height * .19,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(height: 50),
                    _emailPasswordWidget(),
                    SizedBox(height: 20),
                    _submitButton(),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerRight,
                      // child: Text('Forgot Password ?',
                      //     style: TextStyle(
                      //         fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                    _divider(),
                    SizedBox(height: 20),
                    _googleButton(),
                    SizedBox(height: 20),
                    _createAccountLabel(),
                  ],
                ),
              ),
            ),
            // Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
