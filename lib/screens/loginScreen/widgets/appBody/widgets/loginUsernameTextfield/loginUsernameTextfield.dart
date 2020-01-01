import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../../../../data/loginScreenData/userInfo.dart';
import '../../../../../../data/loginScreenData/textFieldInputFormatters/noQuotesTextFieldInputFormatter.dart';

class LoginUsernameTextField extends StatelessWidget {

  static final UserCredentials _credentials = new UserCredentials();

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      autocorrect: false,
      textDirection: TextDirection.ltr,
      maxLength: 200,
      textAlign: TextAlign.center,
      inputFormatters: <TextInputFormatter>[
        NoQuotesTextFieldFormatter(),
      ],
      decoration: InputDecoration(
        hintText: 'Username',
        counterText: '',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onChanged: (value) {
        _credentials.userCredentials['username'] = value;
      },
    );
  }
}