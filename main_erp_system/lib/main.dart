import 'package:flutter/material.dart';
import 'package:main_erp_system/Auth/Login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ".ERP System",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(
          //body: LoginScreen(),
          ),
    );
  }
}
