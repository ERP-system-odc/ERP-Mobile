import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_locales/flutter_locales.dart';
import 'package:main_erp_system/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  var Items = [];

  var map = new Map<String, dynamic>();

  void Stand(
    String standard_name,
    inventory_name,
    inventory_quantity,
  ) async {
    try {
      final mybodys = json.encode({
        map['standard_name'] = 'standard_name',
        map['inventory_name'] = 'inventory_name',
        map['inventory_quantity'] = 'inventory_quantity',
        //"standard_name": standard_name,
        //"inventory_name": Items.toString(),
        //"inventory_name": inventory_name,
        //"inventory_quantity": inventory_quantity,
      });

      final prefsTr = await SharedPreferences.getInstance();
      final tokenn = prefsTr.getString('token');
      print("_------------------");
      print(tokenn);

      final standa = await SharedPreferences.getInstance();
      final standart = standa.getString('inventory_name');
      //final standart = standa.getString(inventory_name);
      print("_---------your data shared---------");
      print(standart);

      var response = await http.post(
          Uri.parse('http://localhost:5000/api/standard/manage'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenn',
          },
          body: mybodys);
      try {
        if (response.statusCode == 200) {
          print('inventory added');
        } else {
          print(response.statusCode);
          print(response.body);
          print('faild to load your inventory');
          print(
              '--------------------this is your inventory token---------------');
          print(tokenn);
          print("------------items----------");
          print(Items);
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
                Text('Inventory Name: ${inventory_name.text}'),
                Text('Inventory Quantity : ${inventory_quantity.text}'),
              ],
            )))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Your Standard Here'),
      ),
      body: Column(
        children: [
          Stepper(
            type: StepperType.vertical,
            currentStep: _activeStepIndex,
            steps: stepList(),
            onStepContinue: () {
              onPressed:
              () {
                Stand(
                  standard_name.text.toString(),
                  inventory_name.text.toString(),
                  inventory_quantity.text.toString(),
                );
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
    );
  }
}
