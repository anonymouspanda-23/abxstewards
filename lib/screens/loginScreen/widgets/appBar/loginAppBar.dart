import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginAppBar extends StatelessWidget with PreferredSizeWidget{

  final double height;

  LoginAppBar ({Key key, @required this.height})
      : assert(height != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: height / 10,
      child: new AppBar(
        title: new Text("Login"),
        centerTitle: true,
        backgroundColor: new Color(0xffa81c31),
        leading: new Container(),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}