import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'display_journal.dart';
import '../../uitls/color_utils.dart';

class Journals extends StatefulWidget {
  const Journals({Key? key}) : super(key: key);

  @override
  State<Journals> createState() => _JournalsState();
}

class _JournalsState extends State<Journals> {
  TextEditingController date = TextEditingController();
  @override
  void initState() {
    super.initState();
    date.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Journal Entry"),
      ),
      body: Center(
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
                    labelText: "Enter Date",
                    labelStyle: TextStyle(color: Color(0xFF5048E5)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF5048E5), width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF5048E5), width: 2.0)),
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
                    addJournal(context);
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
    );
  }

  void addJournal(BuildContext context) {
    String dateToSend = date.text;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => GetJournal(text: date.text)));
  }
}
  //   Future<String> addJournal() async {
  //   final prefsTr = await SharedPreferences.getInstance();
  //   final tokenn = prefsTr.getString('token');
  //   var dates = date.text;
  //   print("_------------------");
  //   var response = await http.post(
  //       Uri.parse("http://localhost:5000/api/journalEntry/manage/$dates"),
  //       body: json.encode({"journal_entry_date": date.text}),
  //       headers: {
  //         'Authorization': 'Bearer $tokenn',
  //         'Content-Type': 'application/json'
  //       });
  //   if (response.statusCode == 200) {
  //     print(json.decode(response.body));
  //     print("yep its working");
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  //   return "";
  // }

