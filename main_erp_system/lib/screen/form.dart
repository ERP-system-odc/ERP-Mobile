import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class form_page extends StatefulWidget {
  @override
  State<form_page> createState() => _FormState();
}

class _FormState extends State<form_page> {
  TextEditingController nameController = TextEditingController();
  TextEditingController capital = TextEditingController();
  TextEditingController livingaddress = TextEditingController();
  TextEditingController businessSubType = TextEditingController();
  TextEditingController tinNumber = TextEditingController();
  String tinNumbererror = "";
  
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
        backgroundColor: Color.fromARGB(255, 80, 72, 229),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: (Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_alert,
              size: 70,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  fillColor: Color(0xff5048E5),
                  border: OutlineInputBorder(),
                  labelText: 'Business name',
                ),
                controller: nameController,
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Business sub Type',
                ),
                controller: businessSubType,
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'capital',
                ),
                controller: capital,
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tin Number',
                ),
                controller: tinNumber,
                keyboardType: TextInputType.text,
              ),
            ),
            Container(
              color: const Color(0xff5048E5),
              child: SizedBox(
                width: 200,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      register();
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            )
          ],
        )),
      )),
    );
  }

  Future<void> register() async {
    String accessToken = jsonDecode('access-token');
    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://localhost:5000/api/firmDefinition/defineFirm/$accessToken'));
    request.body = json.encode({
      "business_name": nameController.text,
      "business_sub_type": businessSubType.text,
      "initial_capital": capital.text,
      "tin_number": tinNumber.text
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
