import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:main_erp_system/Access/getstock.dart';
import 'package:main_erp_system/utils/color_utils.dart';
import 'package:main_erp_system/Auth/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class stock_page extends StatefulWidget {
  @override
  State<stock_page> createState() => _FormState();
}

class _FormState extends State<stock_page> {
  TextEditingController productQuantity = TextEditingController();
  TextEditingController sellingPrice = TextEditingController();
  TextEditingController productStandard = TextEditingController();
  TextEditingController productExpense = TextEditingController();
  Future<String> addStock() async {
    final prefsTr = await SharedPreferences.getInstance();
    final tokenn = prefsTr.getString('token');
    print("_------------------");

    var request = await http.post(
        Uri.parse('http://localhost:5000/api/product/manage'),
        body: json.encode({
          "product_quantity": productQuantity.text,
          "product_selling_price": sellingPrice.text,
          "product_standard": productStandard.text,
          "product_expense": productExpense.text,
        }),
        headers: {
          'Authorization': 'Bearer $tokenn',
          'Content-Type': 'application/json'
        });
    if (request.statusCode == 200) {
      print(json.decode(request.body));
    } else {
      print(request.reasonPhrase);
    }
    return "";
  }

  bool validateStructure(String value) {
    String pattern = r'^([0-9])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  String selectedBusiness = "";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const LocaleText("please_add_your_stock_here"),
          backgroundColor: Color(0xFF5048E5),
          bottom: TabBar(labelStyle: const TextStyle(fontSize: 20), tabs: [
            Container(
              height: 35,
              child: const Text("Add Stock"),
            ),
            Container(
              height: 35,
              child: const Text("View Stock"),
            )
          ]),
        ),
        body: TabBarView(children: [
          Center(
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
                      labelText: 'Amount(Quantity)',
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
                    controller: productQuantity,
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
                      labelText: 'Selling Price',
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
                    controller: sellingPrice,
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
                      labelText: 'Standard',
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
                    controller: productStandard,
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
                      labelText: 'Expense',
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
                    controller: productExpense,
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                        addStock();
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
          Center(
            child: ShowProducts(),
          )
        ]),
      ),
    );
  }
}
