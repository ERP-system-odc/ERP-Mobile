import 'dart:convert';
import 'dart:developer';
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
  TextEditingController product_quantity = TextEditingController();
  TextEditingController product_selling_price = TextEditingController();
  TextEditingController product_standard = TextEditingController();
  TextEditingController product_expense = TextEditingController();

  void stocko(
    product_quantity,
    product_selling_price,
    product_standard,
    product_expense,
  ) async {
    try {
      final stockbo = json.encode({
        "product_quantity": product_quantity,
        'product_selling_price': product_selling_price,
        "product_standard": product_standard,
        "product_expense": product_expense,
      });

      final prefsTr = await SharedPreferences.getInstance();
      final tokenn = prefsTr.getString('token');
      print("_------------------");
      print(tokenn);

      var response =
          await http.post(Uri.parse('http://localhost:5000/api/product/manage'),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $tokenn',
              },
              body: stockbo);
      try {
        if (response.statusCode == 200) {
          print('product added');
        } else {
          print(response.statusCode);
          print(response.body);
          print('faild to load your product');
        }
      } catch (e) {
        print(e.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

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
                    controller: product_quantity,
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
                    controller: product_selling_price,
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
                    controller: product_standard,
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
                    controller: product_expense,
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
                        stocko(
                          product_quantity.text.toString(),
                          product_selling_price.text.toString(),
                          product_standard.text.toString(),
                          product_expense.text.toString(),
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
          Center(
            child: ShowProducts(),
          )
        ]),
      ),
    );
  }
}
