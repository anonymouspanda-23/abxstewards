import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'widgets/appBar/homeScreenAppBar.dart';
import 'widgets/appBody/homeScreenAppBody.dart';

import 'package:connectivity/connectivity.dart';
import '../../services/uploadJSON/uploadJSON.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  final Connectivity _connectivity = new Connectivity();
  StreamSubscription<ConnectivityResult> _connectionSubscription;

  @override
  void initState() {
    _connectionSubscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) async {
      print(result.toString());
      if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile)
        await Upload().uploadLocal();
    });
    super.initState();
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onTapGesture,
      child: new Scaffold(
        appBar: HomeScreenAppBar(height: MediaQuery.of(context).size.height),
        body: HomeScreenAppBody(),
      ),
    );
  }

  onTapGesture() {
    if(!WidgetsBinding.instance.focusManager.rootScope.hasPrimaryFocus)
      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }
}