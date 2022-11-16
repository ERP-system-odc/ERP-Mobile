import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../journal_entry/display_journal.dart';
import 'display_asset_ledger.dart';
import 'display_capital_ledger.dart';
import 'display_expense_ledger.dart';
import 'display_liability_ledger.dart';
import 'display_revenue_ledger.dart';

class GeneralLedgers extends StatefulWidget {
  const GeneralLedgers({Key? key}) : super(key: key);

  @override
  State<GeneralLedgers> createState() => _LedgerState();
}

class _LedgerState extends State<GeneralLedgers> {
  TextEditingController date = TextEditingController();
  TextEditingController date2 = TextEditingController();
  @override
  void initState() {
    super.initState();
    date.text = "";
    date2.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("General Ledger"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5.0),
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
                          labelText: "Enter Initial Date",
                          labelStyle: TextStyle(color: Color(0xFF5048E5)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF5048E5), width: 2.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF5048E5), width: 2.0)),
                          suffixIcon: Icon(Icons.calendar_today)),
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      controller: date,
                      onTap: () async {
                        DateTime? _date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2001),
                            lastDate: DateTime(2222));
                        if (_date != null) {
                          setState(() {
                            date.text = DateFormat('yyyy-MM-dd').format(_date);
                          });
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Enter Final Date",
                          labelStyle: TextStyle(color: Color(0xFF5048E5)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF5048E5), width: 2.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF5048E5), width: 2.0)),
                          suffixIcon: Icon(Icons.calendar_today)),
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      controller: date2,
                      onTap: () async {
                        DateTime? _date2 = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2001),
                            lastDate: DateTime(2222));
                        if (_date2 != null) {
                          setState(() {
                            date2.text =
                                DateFormat('yyyy-MM-dd').format(_date2);
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  GridView.count(
                    crossAxisCount: 2,
                    children: [
                      Card(
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () => {
                            addLedger(context)
                            // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  GetLedger(text: date.text, text2: date2.text,))),
                          },
                          child: Center(
                            child: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Icon(Icons.assessment),
                                Text("Asset Ledger")
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        GetLiabilityLedger(
                                          text: date.text,
                                          text2: date2.text,
                                        ))),
                          },
                          child: Center(
                            child: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Icon(Icons.assessment),
                                Text("Liability Ledger")
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ExpenseLedger(
                                          text: date.text,
                                          text2: date2.text,
                                        ))),
                          },
                          child: Center(
                            child: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Icon(Icons.assessment),
                                Text("Expense Ledger")
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        RevenueLedger(
                                          text: date.text,
                                          text2: date2.text,
                                        ))),
                          },
                          child: Center(
                            child: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Icon(Icons.assessment),
                                Text("Revenue Ledger")
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CapitalLedger(
                                          text: date.text,
                                          text2: date2.text,
                                        ))),
                          },
                          child: Center(
                            child: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Icon(Icons.assessment),
                                Text("Capital Ledger")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addLedger(BuildContext context) {
    //  String dateToSend = date.text;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                GetLedger(text: date.text, text2: date2.text)));
  }
}
