import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../uitls/color_utils.dart';

class Inventory extends StatefulWidget {
  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  TextEditingController inventory_name = TextEditingController();
  TextEditingController inventory_price = TextEditingController();
  TextEditingController least_critical_amount = TextEditingController();
  TextEditingController total_amount = TextEditingController();
  Future<String> insert() async {
    final prefsTr = await SharedPreferences.getInstance();
    final tokenn = prefsTr.getString('token');
    print("_------------------");

    var request = await http.post(
        Uri.parse('http://localhost:5000/api/inventory/manage'),
        body: json.encode({
          "inventory_name": inventory_name.text,
          "inventory_price": inventory_price.text,
          "least_critical_amount": least_critical_amount.text,
          "inventory_quantity": total_amount.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("please_add_your_materials_here"),
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
                controller: total_amount,
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
                    insert();
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
