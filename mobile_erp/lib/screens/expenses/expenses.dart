import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../uitls/color_utils.dart';
import 'get_expenses.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  TextEditingController expenseName = TextEditingController();
  TextEditingController expenseAmount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add all your Expenses Here"),
          bottom: TabBar(
            labelStyle: const TextStyle(fontSize: 20),
            tabs: [
              Container(
                height: 35,
                child: const Text("Add "),
              ),
              Container(
                height: 35,
                child: const Text("View "),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Expense Name",
                          labelStyle: TextStyle(color: Color(0xFF5048E5)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF5048E5), width: 2.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF5048E5), width: 2.0)),
                          suffixIcon: Icon(Icons.money)),
                      keyboardType: TextInputType.text,
                      controller: expenseName,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Expense Price",
                          labelStyle: TextStyle(color: Color(0xFF5048E5)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF5048E5), width: 2.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF5048E5), width: 2.0)),
                          suffixIcon: Icon(Icons.money)),
                      keyboardType: TextInputType.text,
                      controller: expenseAmount,
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
                          addExpense();
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
            ),
            Center(
              child: GetExpense(),
            )
          ],
        ),
      ),
    );
  }

  Future<String> addExpense() async {
    final prefsTr = await SharedPreferences.getInstance();
    final tokenn = prefsTr.getString('token');
    print("_------------------");
    var response = await http.post(
        Uri.parse("http://localhost:5000/api/expense/manage"),
        body: json.encode({
          "expense_name": expenseName.text,
          "expense_amount": expenseAmount.text
        }),
        headers: {
          'Authorization': 'Bearer $tokenn',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Expense added successfully"),
      ));
    } else {
      print(response.reasonPhrase);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Current capital isn't enough to process the request"),
      ));
    }
    return "";
  }
}
