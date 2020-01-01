import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../appBody/widgets/messageDialog/messageDialog.dart';

class HomeScreenAppBar extends StatelessWidget with PreferredSizeWidget{

  final double height;
  static BuildContext thisContext;
  final List<String> choices = ['About App', 'Help'];

  HomeScreenAppBar ({Key key, @required this.height})
      : assert(height != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    thisContext = context;
    return new Container(
      height: height / 10,
      child: new AppBar(
        title: new Text("EDURTI"),
        centerTitle: true,
        backgroundColor: new Color(0xffa81c31),
        leading: new Container(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: _select,
          )
        ],
      ),
    );
  }

  _select() {
    return MessageDialog().showInfo(
      thisContext,
      'About App',
      'Get recommendations on whether antibiotics is required for your uncomplicated URTI patient, based '
      'on results from 3 validated models developed from local epidemiological and clinical data obtained '
      'from an adult ED in Singapore.\n'
      '\n'
      'NOTE: Remember to open up the app when there\'s internet connection for data synchronization purposes.',
      'Admin Contact Info',
      'Email: weixiang_lian@ttsh.com.sg',
      false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}