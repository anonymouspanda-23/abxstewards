import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../popupNotification/forgotPasswordNotification.dart';

class LoginPageForgotPassword extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('Forgot password?'),
      onPressed: () {
        PopUpNotification().popup(context);
      },
    );
  }
}