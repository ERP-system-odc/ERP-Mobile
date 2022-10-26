import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:http/http.dart' as http;
import 'package:main_erp_system/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Inventory extends StatefulWidget {
  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  TextEditingController inventory_name = TextEditingController();
  TextEditingController inventory_price = TextEditingController();
  TextEditingController least_critical_amount = TextEditingController();
  TextEditingController inventory_quantity = TextEditingController();

  void Invent(
    String inventory_name,
    inventory_price,
    least_critical_amount,
    inventory_quantity,
  ) async {
    try {
      final mybody1 = json.encode({
        "inventory_name": inventory_name,
        "inventory_price": inventory_price,
        "least_critical_amount": least_critical_amount,
        "inventory_quantity": inventory_quantity,
      });

      var Tokenw =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFjZmY1ZWJlLWM0NWYtNDc2OC1hZTBmLWI0NWZhYmYxMDg5MSIsImlzX2FkbWluIjpmYWxzZSwiaWF0IjoxNjY2Njg3Mjc5fQ.JJwXftvfP37kWsxSdGqDeAkkF8PG3XyvX4NAYk0r7xQ';

      final prefsTr = await SharedPreferences.getInstance();
      final tokenn = prefsTr.getString('token');
      print("_------------------");
      print(tokenn);

      var response = await http.post(
          Uri.parse('http://localhost:5000/api/inventory/manage'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenn',
          },
          body: mybody1);

      try {
        if (response.statusCode == 200) {
          print('inventory added');
        } else {
          print(response.statusCode);
          print(response.body);
          print('faild to load your inventory');
          print(
              '--------------------this is your inventory token---------------');
          //print(tokenn);
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
      appBar: AppBar(
        title: const LocaleText("please_add_your_materials_here"),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: (Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/bl.png",
                height: 120,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Inventory Name',
                  labelStyle: TextStyle(
                    color: Color(0xFF5048E5),
                  ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  suffixIcon: Icon(Icons.precision_manufacturing,
                      color: Color(0xFF5048E5)),
                ),
                controller: inventory_name,
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
                  labelText: 'Inventory Price',
                  labelStyle: TextStyle(
                    color: Color(0xFF5048E5),
                  ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  suffixIcon: Icon(Icons.money, color: Color(0xFF5048E5)),
                ),
                controller: inventory_price,
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
                  labelText: ' least Critical Amount ',
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
                      Icon(Icons.cached_rounded, color: Color(0xFF5048E5)),
                ),
                controller: least_critical_amount,
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
                  labelText: 'Quantity',
                  labelStyle: TextStyle(
                    color: Color(0xFF5048E5),
                  ),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                  suffixIcon: Icon(Icons.balance, color: Color(0xFF5048E5)),
                ),
                controller: inventory_quantity,
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
                  onPressed: () {
                    Invent(
                      inventory_name.text.toString(),
                      inventory_price.text.toString(),
                      least_critical_amount.text.toString(),
                      inventory_quantity.text.toString(),
                    );
                  },
                  child: const LocaleText(
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
            // Container(
            //   color: const Color(0xFF5048E5),
            //   child: SizedBox(
            //     width: 200,
            //     height: 50,
            //     child: TextButton(
            //         onPressed: () {
            //           insert();
            //         },
            //         child: const Text(
            //           "Submit",
            //           style: TextStyle(color: Colors.white),
            //         )),
            //   ),
            // )
          ],
        )),
      )),
    );
  }
}
