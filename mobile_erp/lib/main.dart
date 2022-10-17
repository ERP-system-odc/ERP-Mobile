import 'package:erp_mobile/uipage/dashboard.dart';
import 'package:erp_mobile/uipage/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(myApp());

class myApp extends StatefulWidget {
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
