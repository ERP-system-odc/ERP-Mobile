import 'package:flutter/material.dart';
import 'screens/login.dart';

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
