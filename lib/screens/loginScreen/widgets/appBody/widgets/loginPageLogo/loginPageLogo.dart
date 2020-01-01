import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoginPageLogo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'hero',
        child: new Image(
          image: new AssetImage("assets/ttsh_logo.png"),
          width: 200,
          height: 200,
          color: null,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        )
    );
  }
}