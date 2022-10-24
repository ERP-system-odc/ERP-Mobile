import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:main_erp_system/utils/color_utils.dart';
import 'package:main_erp_system/Auth/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class form_pagee extends StatefulWidget {
  @override
  State<form_pagee> createState() => _FormState();
}

class _FormState extends State<form_pagee> {
  TextEditingController business_name = TextEditingController();
  // TextEditingController livingaddress = TextEditingController();
  TextEditingController business_type = TextEditingController();
  TextEditingController business_sub_type = TextEditingController();
  TextEditingController business_capital = TextEditingController();
  TextEditingController tin_number = TextEditingController();
  String tinNumbererror = "";

  void register(
    String business_name,
    business_type,
    business_sub_type,
    business_capital,
    tin_number,
  ) async {
    try {
      final mybody1 = json.encode({
        "business_name": business_name,
        "business_type	": business_type,
        "business_sub_type": business_sub_type,
        "business_capital": business_capital,
        "tin_number": tin_number,
      });

      var Token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFkZDg2NDdlLWEwMWQtNDNlNS05YzYwLWI0YjRjOTgwNDIyNyIsImlzX2FkbWluIjpmYWxzZSwiaWF0IjoxNjY2NjEyMzExfQ.eePmX_vWD8xs1vwkm5Lp-0MIuRyOtEpzHLSgPwbNvkE';
      final prefsT = await SharedPreferences.getInstance();
      final accessToken = prefsT.getString('token');
      print("_------------------");
      print(accessToken);

      Response response = await post(
          Uri.parse('http://localhost:5000/api/firmDefinition/defineFirm/'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: mybody1);

      try {
        if (response.statusCode == 200) {
          print('you added your business');
        } else {
          print(response.statusCode);
          print('faild to load');
        }
      } catch (e) {
        print(e.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  bool validateStructure(String value) {
    String pattern = r'^([0-9])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  String selectedBusiness = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Please Add Materials here"),
        backgroundColor: Color(0xFF5048E5),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: (Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text(widget.accessToken),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Business name',
                  labelStyle: TextStyle(
                    color: Color(0xFF5048E5),
                  ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  suffixIcon:
                      Icon(Icons.remove_red_eye, color: Color(0xFF5048E5)),
                ),
                controller: business_name,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Busines Type',
                  labelStyle: TextStyle(
                    color: Color(0xFF5048E5),
                  ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  suffixIcon:
                      Icon(Icons.remove_red_eye, color: Color(0xFF5048E5)),
                ),
                controller: business_type,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Business sub Type',
                  labelStyle: TextStyle(
                    color: Color(0xFF5048E5),
                  ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  suffixIcon:
                      Icon(Icons.remove_red_eye, color: Color(0xFF5048E5)),
                ),
                controller: business_sub_type,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'capital',
                  labelStyle: TextStyle(
                    color: Color(0xFF5048E5),
                  ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  suffixIcon:
                      Icon(Icons.remove_red_eye, color: Color(0xFF5048E5)),
                ),
                controller: business_capital,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tin Number',
                  labelStyle: TextStyle(
                    color: Color(0xFF5048E5),
                  ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  suffixIcon:
                      Icon(Icons.remove_red_eye, color: Color(0xFF5048E5)),
                ),
                controller: tin_number,
                keyboardType: TextInputType.text,
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
                    hexStringToColor('5048E5'),
                    hexStringToColor("5048E5"),
                  ]),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    register(
                      business_name.text.toString(),
                      business_type.text.toString(),
                      business_sub_type.text.toString(),
                      business_capital.text.toString(),
                      tin_number.text.toString(),
                      // tinNumbererror.text.toString(),
                    );
                  },
                  child: const Text(
                    "Submit",
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
          ],
        )),
      )),
    );
  }
}
