import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class Inventory extends StatefulWidget {
  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  TextEditingController materialController = TextEditingController();
  TextEditingController measurementType = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController critical_amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Please Add Materials here"),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: (Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              size: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'name of material',
                ),
                controller: materialController,
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ' Price in piece ',
                ),
                controller: price,
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ' least critical Amount ',
                ),
                controller: critical_amount,
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'measured in..',
                ),
                controller: measurementType,
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'amount (quantitty)',
                ),
                controller: amount,
                keyboardType: TextInputType.text,
              ),
            ),
            Container(
              color: const Color(0xff2196F3),
              child: SizedBox(
                width: 200,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      insert();
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

  Future<void> insert() async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdmNWJlYjc0LWE0ZmEtNGJmOS1iOGY3LTE4YWYzYTVlNjQ2NyIsImlzX2FkbWluIjpmYWxzZSwiaWF0IjoxNjY2Mjc5MTY2fQ.IdWp4L2lx9hYIfONJJBIveONEU0cNJe-_j7Gt4pQr6w',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('http://localhost:5000/api/inventory/manage'));
    request.body = json.encode({
      "inventory_name": materialController.text,
      "inventory_price": price.text,
      "least_critical_amount": critical_amount.text,
      "inventory_expense": measurementType.text,
      "inventory_quantity": amount.text,
    });
    var jsonresponse = json.decode(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
