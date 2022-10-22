import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:main_erp_system/Auth/Signup.dart';
import 'package:main_erp_system/dashboard/dashboard.dart';
import 'package:main_erp_system/utils/color_utils.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    print(email);
    // var token = prefs.getString('access-token');
    // print(token);
    var token;
    addTokenToSF() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('access-token', token);
    }

    runApp(MaterialApp(home: email == null ? dashboard() : dashboard()));
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Object? get tokenValue => null;
  // getTokenFromSF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var tokenValue = prefs.getString('access-token');
  //   return tokenValue;
  // }

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

      var request = await http.post(
          Uri.parse('http://localhost:5000/api/auth/signin'),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: myBody);

      try {
        //print(jsonDecode(response.body.toString()));
        if (response.statusCode == 200) {
          if (request.statusCode == 200) {
            print(json.decode(request.body));
            var token = json.decode(request.body)["access-token"];
            print('this is your token ' + token);

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const dashboard()));
          } else {
            print('\n token faild \n');
          }

          // var data = jsonDecode(response.body);
          // //token = json.decode(re)
          // print(data);
          // print('you are loged in');
        } else {
          print('faild to Login ');
        }
      } catch (e) {
        print(e.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
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
                //autofocus: false,
                //validator: (value) => value!.isEmpty ? 'please enter' : null,
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
                  prefixIcon: Icon(Icons.lock, color: Color(0xFF42A5F5)),
                  suffixIcon:
                      Icon(Icons.remove_red_eye, color: Color(0xFF2196F3)),
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
                      onPressed: () {}, child: const Text("Forget Password?"))
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
                    hexStringToColor('2196F3'),
                    hexStringToColor("2196F3"),
                  ]),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    login(emailController.text.toString(),
                        passwordController.text.toString());

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('email', 'useremail@gmail.com');

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext ctx) => dashboard()));
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
                      },
                      child: const Text("SignUp"))
                ],
              ),
            ),
          ],
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
