import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'display_asset_ledger.dart';

class ExpenseLedger extends StatefulWidget {
  String text;
  String text2;
  ExpenseLedger({
    Key? key,
    required this.text,
    required this.text2,
  }) : super(key: key);

  @override
  State<ExpenseLedger> createState() => _ExpenseLedgerState(text, text2);
}

class _ExpenseLedgerState extends State<ExpenseLedger> {
  late Future<GeneralLedger> expenseBuilder;
  String text;
  String text2;
  _ExpenseLedgerState(this.text, this.text2);
  void initState() {
    super.initState();
    expenseBuilder = fetchExpense(text, text2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Container(
        child: FutureBuilder<GeneralLedger>(
            future: expenseBuilder,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.liabilityGeneralLedger.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          shape: const BeveledRectangleBorder(
                              side: BorderSide(
                                  color: Color(0xFF5048E5),
                                  strokeAlign: StrokeAlign.outside)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                  'Description: ${snapshot.data!.expenseGeneralLedger[index].description}'),
                              Text(
                                  'Date: ${snapshot.data!.expenseGeneralLedger[index].transactionDate}'),
                              Text(
                                  'Balance: ${snapshot.data!.expenseGeneralLedger[index].balanceCredit}'),
                              Text(
                                  'Balance: ${snapshot.data!.expenseGeneralLedger[index].balanceDebit}'),
                              Text(
                                  'Credit: ${snapshot.data!.expenseGeneralLedger[index].credit}'),
                              Text(
                                  'debit: ${snapshot.data!.expenseGeneralLedger[index].debit}'),
                              // Text('Asset-Balance: ${snapshot.data!.liabilityGeneralLedger
                              //     .toString()}'),
                            ],
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                print(snapshot.error);
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }

  Future<GeneralLedger> fetchExpense(String text, text2) async {
    final prefsTr = await SharedPreferences.getInstance();
    final tokenn = prefsTr.getString('token');
    print("_------------------");

    var headers = {
      'Authorization': 'Bearer $tokenn',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
        Uri.parse(
            'http://localhost:5000/api/generalLedger/manage/$text/$text2'),
        headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      return GeneralLedger.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
