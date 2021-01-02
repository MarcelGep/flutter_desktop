import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_desktop/database/auth_helper.dart';
import 'package:flutter_desktop/database/database_helper.dart';
import 'package:flutter_desktop/helpers/dialog_helper.dart';
import 'package:flutter_desktop/routes/routes.dart';
import 'package:flutter_desktop/widgets/bezier_container.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signup';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController usernameController = new TextEditingController();

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

  Widget _submitButton() {
    final RoundedLoadingButtonController _btnController =
        new RoundedLoadingButtonController();

    return RoundedLoadingButton(
      width: MediaQuery.of(context).size.width,
      color: Colors.orange[600],
      borderRadius: 0,
      successColor: Colors.green,
      child: Text('Registrieren',
          style: TextStyle(fontSize: 22, color: Colors.white)),
      controller: _btnController,
      onPressed: () async {
        String errorMessage;

        if (usernameController.text.isEmpty) {
          errorMessage = "Bitte Benutzername angeben!";
        } else {
          String result = await AuthHelper.signUpWithEmail(
              email: emailController.text, password: passwordController.text);
          print(result);
          if (result == 'email-already-in-use')
            errorMessage = "E-Mail Adresse wird bereits verwendet";
          if (result == 'invalid-email')
            errorMessage = "Ungültige E-Mail Adresse";
          if (result == 'missing-email')
            errorMessage = "Keine E-Mail Adresse angegeben";
          if (result == 'weak-password')
            errorMessage = "Das Password ist zu unsicher";
          if (result == 'unknown') errorMessage = "Unbekannter Fehler";
        }

        if (errorMessage != null) {
          _btnController.error();
          passwordController.clear();
          DialogsHelper.showErrorFlushbar(context, errorMessage);
          Timer(Duration(milliseconds: 1500), () {
            _btnController.reset();
          });
        } else {
          _btnController.success();
          DatabaseHelper.addUserData(usernameController.text);
          Timer(Duration(milliseconds: 1000), () {
            Navigator.pushReplacementNamed(context, Routes.customers);
          });
        }
      },
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Account existiert bereits?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
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
        _entryField("Benutzername", usernameController),
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
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    SizedBox(height: 20),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Mainpage {}
