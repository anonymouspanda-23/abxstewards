import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/loginPageLogo/loginPageLogo.dart';
import 'widgets/loginUsernameTextfield/loginUsernameTextfield.dart';
import 'widgets/loginPasswordTextfield/loginPasswordTextfield.dart';
import 'widgets/loginButton/loginButton.dart';
import 'widgets/loginPageForgotPassword/loginPageForgotPassword.dart';

class LoginAppBody extends StatefulWidget {
  @override
  LoginAppBodyState createState() => LoginAppBodyState();
}

class LoginAppBodyState extends State<LoginAppBody>{

  @override
  Widget build(BuildContext context) {

    final loginPageLogo = LoginPageLogo();
    final usernameTextField = LoginUsernameTextField();
    final passwordTextField = LoginPasswordTextField();
    final loginButton = new LoginButton();
    final forgotPasswordLabel = LoginPageForgotPassword();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 24.0),
            loginPageLogo,
            SizedBox(height: 48.0),
            usernameTextField,
            SizedBox(height: 8.0),
            passwordTextField,
            SizedBox(height: 24.0),
            loginButton,
            forgotPasswordLabel
          ],
        ),
      ),
    );
  }
}