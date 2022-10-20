import 'package:flutter/material.dart';
import 'package:main_erp_system/Auth/Login.dart';
import 'package:main_erp_system/utils/color_utils.dart';
import 'package:main_erp_system/dashboard/dashboard.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phnoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();

  void login(
    String full_name,
    email,
    phone_number,
    password,
    confirm_password,
  ) async {
    try {
      final myBody = json.encode({
        'full_name': full_name,
        'email': email,
        'phone_number': phone_number,
        'password': password,
        'confirm_password': confirm_password,
      });

      Response response = await post(
          Uri.parse('http://localhost:5000/api/auth/signup'),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: myBody);

      try {
        print(jsonDecode(response.body.toString()));
        if (response.statusCode == 200) {
          // var data = jsonDecode(response.body.toString());
          // print(data);
          print('account is created successfully');

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
          // } else {
          //   print('failed');
          // }
        }
      } catch (e) {
        print(e.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      //padding: const EdgeInsets.all(30),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        hexStringToColor('2196F3'),
                        hexStringToColor("2196F3"),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/pp.png",
                        color: Color(0xFFFFFFFF),
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF2196F3), width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF2196F3), width: 2.0)),
                    prefixIcon: Icon(Icons.person, color: Color(0xFF2196F3)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF2196F3), width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF2196F3), width: 2.0)),
                    prefixIcon: Icon(Icons.email, color: Color(0xFF2196F3)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  controller: phnoController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Phone No",
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF2196F3), width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF2196F3), width: 2.0)),
                    prefixIcon: Icon(Icons.phone, color: Color(0xFF2196F3)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF2196F3), width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF2196F3), width: 2.0)),
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF2196F3)),
                    suffixIcon:
                        Icon(Icons.remove_red_eye, color: Color(0xFF2196F3)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  controller: confirmpassController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF2196F3), width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF2196F3), width: 2.0)),
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF2196F3)),
                    suffixIcon:
                        Icon(Icons.remove_red_eye, color: Color(0xFF2196F3)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //color: Color(0xFF42A5F5),
                    gradient: LinearGradient(colors: [
                      hexStringToColor('2196F3'),
                      hexStringToColor("2196F3"),
                    ]),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      login(
                          nameController.text.toString(),
                          emailController.text.toString(),
                          phnoController.text.toString(),
                          passwordController.text.toString(),
                          confirmpassController.text.toString());

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext ctx) => dashboard()));
                    },
                    child: const Text(
                      "SIGNUP",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
