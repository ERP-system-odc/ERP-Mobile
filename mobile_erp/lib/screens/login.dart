// ignore_for_file: use_key_in_widget_constructors
import 'dart:convert';
import 'package:erp_mobile/uipage/dashboard.dart';
import 'package:erp_mobile/uipage/main_dash.dart';
import 'package:erp_mobile/uipage/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: SafeArea(
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          label: Text("email"),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.email)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                          label: Text("password"),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.password)),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        signIn();
                      },
                      icon: const Icon(Icons.login),
                      label: const Text("Login"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "New User?",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          child: const Text("Signup"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future<void> signIn() async {
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse("http://localhost:5000/api/signin"),
          body: ({
            'email': emailController.text,
            'password': passwordController.text
          }));
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Incorrect Login Credentials")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Field must be Filled!")));
    }
  }
}
