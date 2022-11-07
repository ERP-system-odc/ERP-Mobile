import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StandardMod {
  String? standard_name;
  List<StandardIte>? standard_items;
  StandardMod({this.standard_name, this.standard_items});
  StandardMod.fromJson(Map<String, dynamic> json) {
    standard_name = json['standard_name'];
    if (json['standard_items'] != null) {
      standard_items = <StandardIte>[];
      (json['standard_items'] as List).forEach((e) {
        standard_items!.add(StandardIte.fromJson(e));
      });
      
    }
    
  }
  
}

class StandardIte {
  String? inventory_name;
  String? inventory_quantity;
  StandardIte({this.inventory_name, this.inventory_quantity});

  StandardIte.fromJson(Map<String, dynamic> json) {
    inventory_name = json['inventory_name'];
    inventory_quantity = json['inventory_quantity'];
  }
  
}

class getinventorys2 extends StatefulWidget {
  getinventorys2({Key? key}) : super(key: key);

  @override
  State<getinventorys2> createState() => _MyAppState();
}

class _MyAppState extends State<getinventorys2> {
  StandardMod? standardMod;
  bool? loading;
  Future<Null> _fetchData() async {
    setState(() => loading = true);

    final prefsTr = await SharedPreferences.getInstance();
    final tokenn = prefsTr.getString('token');
    print("_------------------");
    print(tokenn);
    var response =
        await http.post(Uri.parse('http://localhost:5000/api/standard/manage'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $tokenn',
            },
            body: jsonEncode(standardMod));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final ticketModelFromJson = StandardMod.fromJson(data);

      setState(() {
        standardMod = ticketModelFromJson;
        loading = false;
      });
    } else {
      print(response.statusCode);
      print(response.body);
      print("standard faild");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:  Container(
        
              ),
      ),
      
    );
  }
}
