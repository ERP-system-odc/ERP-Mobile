import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_locales/flutter_locales.dart';
import 'package:main_erp_system/Access/getinventory.dart';
import 'package:main_erp_system/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:json_annotation/json_annotation.dart';

class Standardex extends StatefulWidget {
  const Standardex({Key? key}) : super(key: key);
  @override
  _StandardexState createState() => _StandardexState();
}

class _StandardexState extends State<Standardex> {
  int _activeStepIndex = 0;
  TextEditingController standard_name = TextEditingController();
  TextEditingController inventory_name = TextEditingController();
  TextEditingController inventory_quantity = TextEditingController();
  TextEditingController inventory_name2 = TextEditingController();
  TextEditingController inventory_quantity2 = TextEditingController();
  TextEditingController inventory_name3 = TextEditingController();
  TextEditingController inventory_quantity3 = TextEditingController();

  void Stand(
    standard_name,
    inventory_name,
    inventory_quantity,
    inventory_name2,
    inventory_quantity2,
    inventory_name3,
    inventory_quantity3,
  ) async {
    try {
      // stobj.addAll(standard_name);
      // stobj.toString();
      // stobj.addAll(StandardItems);

      //@JsonSerializable(explicitToJson: true)
      // final stobja = json.encode({
      //   "standard_name": standard_name,
      //   'inventory_name': inventory_name,
      //   "inventory_quantity": inventory_quantity,
      // });

      final prefsTr = await SharedPreferences.getInstance();
      final tokenn = prefsTr.getString('token');
      print("_------------------");
      print(tokenn);

      var response = await http.post(
          Uri.parse('http://localhost:5000/api/standard/manage'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenn',
          },
          body: jsonEncode({
            "standard_name": standard_name,
            "standard_items": [
              {
                "inventory_name": inventory_name,
                "inventory_quantity": inventory_quantity
              },
              {
                "inventory_name": inventory_name2,
                "inventory_quantity": inventory_quantity2
              },
              {
                "inventory_name": inventory_name3,
                "inventory_quantity": inventory_quantity3
              }
            ]
          }));
      //print(stobj);
      try {
        if (response.statusCode == 200) {
          print('Standard added');
        } else {
          print(response.statusCode);
          print(response.body);
          print('faild to load your standard');
        }
      } catch (e) {
        print(e.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Standard'),
          content: Container(
            child: Column(
              children: [
                TextFormField(
                  controller: standard_name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Standard Name',
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Standard Items'),
            content: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: inventory_name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Inventory Name',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: inventory_quantity,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Inventory Quantity',
                    ),
                  ),
                ],
              ),
            )),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Standard Items 2'),
            content: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: inventory_name2,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Inventory Name',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: inventory_quantity2,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Inventory Quantity',
                    ),
                  ),
                ],
              ),
            )),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Standard Items 3'),
            content: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: inventory_name3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Inventory Name',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: inventory_quantity3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Inventory Quantity',
                    ),
                  ),
                ],
              ),
            )),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Info'),
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Items[index].add(standard_name),
                //Items={$standard_name},

                Text('Standard Name: ${standard_name.text}'),
                Text('  Inventory Name: ${inventory_name.text}'),
                Text('  Inventory Quantity : ${inventory_quantity.text}'),
                const Text('  ----------------------------'),

                Text('  Inventory Name 2: ${inventory_name2.text}'),
                Text('  Inventory Quantity 2: ${inventory_quantity2.text}'),
                const Text('  ----------------------------'),

                Text('  Inventory Name 3: ${inventory_name3.text}'),
                Text('  Inventory Quantity 3: ${inventory_quantity3.text}'),
              ],
            )))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Your Standard Here'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stepper(
              type: StepperType.vertical,
              currentStep: _activeStepIndex,
              steps: stepList(),
              onStepContinue: () {
                onPressed:
                () {
                  // Stand(
                  //   standard_name.text.toString(),
                  //   inventory_name.text.toString(),
                  //   inventory_quantity.text.toString(),
                  // );
                };
                if (_activeStepIndex < (stepList().length - 1)) {
                  setState(() {
                    _activeStepIndex += 1;
                  });
                } else {
                  print('Submited');
                }
              },
              onStepCancel: () {
                if (_activeStepIndex == 0) {
                  return;
                }
                setState(() {
                  _activeStepIndex -= 1;
                });
              },
              onStepTapped: (int index) {
                setState(() {
                  _activeStepIndex = index;
                });
              },
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
                    Stand(
                      standard_name.text.toString(),
                      inventory_name.text.toString(),
                      inventory_quantity.text.toString(),
                      inventory_name2.text.toString(),
                      inventory_quantity2.text.toString(),
                      inventory_name3.text.toString(),
                      inventory_quantity3.text.toString(),
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
            )
          ],
        ),
      ),
    );
  }
}
