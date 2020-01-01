import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'widgets/appBar/loginAppBar.dart';
import 'widgets/appBody/loginAppBody.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onTapGesture,
      child: new Scaffold(
        appBar: LoginAppBar(height: MediaQuery.of(context).size.height),
        body: LoginAppBody(),
      ),
    );
  }

  void onTapGesture() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }
}
