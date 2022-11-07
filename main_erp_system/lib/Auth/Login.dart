import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:main_erp_system/Auth/Signup.dart';
import 'package:main_erp_system/dashboard/dashboard.dart';
import 'package:main_erp_system/screen/stock.dart';
import 'package:main_erp_system/utils/color_utils.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  //const LoginScreen({Key? key}) : super(key: key);

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    print(email);

    runApp(MaterialApp(home: email == null ? dashboard() : dashboard()));
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(
    String email,
    password,
  ) async {
    try {
      final myBody = json.encode({
        'email': email,
        'password': password,
      });

      Response response = await http.post(
          Uri.parse('http://localhost:5000/api/auth/signin'),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: myBody);

      var request =
          await http.post(Uri.parse('http://localhost:5000/api/auth/signin'),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                //'Authorization': 'Bearer $accessToken',
              },
              body: myBody);

      try {
        //print(jsonDecode(response.body.toString()));
        if (response.statusCode == 200) {
          if (request.statusCode == 200) {
            print(json.decode(request.body));
            var tokenn = json.decode(request.body)["access-token"];

            final sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setString("token", tokenn);
            print('this is your token ' + tokenn);

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const dashboard()));

            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text('user data'),
            //   ),
            // );
          } else {
            print(request.body);
            print('\n token faild \n');
          }
        } else {
          print(response.body);
          print('faild to Login ');
        }
      } catch (e) {
        print(e.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        hexStringToColor('5048E5'),
                        hexStringToColor("5048E5"),
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
                        "assets/images/wl.png",
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "email is required";
                    } else if (RegExp(emailRegex).hasMatch(value)) {
                    } else {
                      return "please enter a valid email!";
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Color(0xFF5048E5),
                    ),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                    prefixIcon: Icon(Icons.email, color: Color(0xFF5048E5)),
                  ),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "password is required";
                    } else if (value.length < 9) {
                      return "must be at least 9 chars";
                    } else {
                      return null;
                    }
                  },
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Color(0xFF5048E5),
                    ),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF5048E5)),
                    suffixIcon:
                        Icon(Icons.visibility_off, color: Color(0xFF5048E5)),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: Color(0xFF5048E5),
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
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
                      hexStringToColor('5048E5'),
                      hexStringToColor("5048E5"),
                    ]),
                  ),
                  child: InkWell(
                    child: MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          login(emailController.text.toString(),
                              passwordController.text.toString());

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('email', 'useremail@gmail.com');

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (BuildContext ctx) => dashboard()));
                        } else {
                          return null;
                        }
                      },
                      child: const Text(
                        "LOGIN",
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
              ),
              //              const SizedBox(
              //                height: 30,
              //              ),
              //              const Icon(Icons.fingerprint , size: 60, color: Colors.teal,),
              //              const SizedBox(
              //                height: 10,
              //              ),
              //              const Divider(
              //                height: 30,
              //                color: Colors.black,
              //              ),
              const SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()));
                        // Fluttertoast.showToast(
                        //   msg: "Login successfull",
                        //   //toastLength: Toast.LENGTH_SHORT,
                        //   //gravity: ToastGravity.CENTER,
                        //   //timeInSecForIosWeb: 1,
                        //   //backgroundColor: Colors.red,
                        //   //textColor: Colors.white,
                        //   //fontSize: 16.0
                        // );
                      },
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                          color: Color(0xFF5048E5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _AuthData {
//   String token, refreshToken;
//   _AuthData(this.token, this.refreshToken);

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();

//     data['token'] = token;
//     data['refreshToken'] = refreshToken;
//     return data;
//   }
// }
