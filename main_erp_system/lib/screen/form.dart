import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:main_erp_system/utils/color_utils.dart';
import 'package:main_erp_system/Auth/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class form_page extends StatefulWidget {
  @override
  State<form_page> createState() => _FormState();
}

class _FormState extends State<form_page> {
  TextEditingController business_name = TextEditingController();
  // TextEditingController business_type = TextEditingController();
  TextEditingController business_sub_type = TextEditingController();
  TextEditingController business_capital = TextEditingController();
  TextEditingController tin_number = TextEditingController();
  String tinNumbererror = "";

  void register(
    String business_name,
    // business_type,
    business_sub_type,
    business_capital,
    tin_number,
  ) async {
    try {
      final mybody1 = json.encode({
        "business_name": business_name,
        // "business_type	": business_type,
        "business_sub_type": business_sub_type,
        "business_capital": business_capital,
        "tin_number": tin_number,
      });

      var Token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFkZDg2NDdlLWEwMWQtNDNlNS05YzYwLWI0YjRjOTgwNDIyNyIsImlzX2FkbWluIjpmYWxzZSwiaWF0IjoxNjY2NjM5NDA3fQ.gL5VOUaNCnxUjJRbv_kVgoRODB_kbo1mi55Kc-hwo_A';

      final prefsTr = await SharedPreferences.getInstance();
      final tokenn = prefsTr.getString('token');
      print("_------------------");
      print(tokenn);

      var response = await http.post(
          Uri.parse('http://localhost:5000/api/firmDefinition/defineFirm/'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenn',
          },
          body: mybody1);

      try {
        if (response.statusCode == 200) {
          print('you added your business');
        } else {
          print(response.statusCode);
          print(response.body);
          print('faild to load');
          print('--------------------this is your token---------------');
          print(tokenn);
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
        title: const LocaleText("please_add_your_firm_here"),
        backgroundColor: Color(0xFF5048E5),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: (Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/bl.png",
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Business Name',
                  labelStyle: TextStyle(
                    color: Color(0xFF5048E5),
                  ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  suffixIcon: Icon(Icons.business, color: Color(0xFF5048E5)),
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
                  labelText: 'Business Sub Type',
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
                      Icon(Icons.business_center, color: Color(0xFF5048E5)),
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
                  labelText: 'Capital',
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
                      Icon(Icons.monetization_on, color: Color(0xFF5048E5)),
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
                  suffixIcon: Icon(Icons.numbers, color: Color(0xFF5048E5)),
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
                width: 200,
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
                      //business_type.text.toString(),
                      business_sub_type.text.toString(),
                      business_capital.text.toString(),
                      tin_number.text.toString(),
                      // tinNumbererror.text.toString(),
                    );
                  },
                  child: const LocaleText(
                    "submit",
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
