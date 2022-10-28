import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Data> fetchAlbum() async {
  final prefsTr = await SharedPreferences.getInstance();
  final tokenn = prefsTr.getString('token');
  print("_------------------");

  var headers = {
    'Authorization': 'Bearer $tokenn',
    'Content-Type': 'application/json',
  };
  final response = await http.get(
      Uri.parse('http://localhost:5000/api/inventory/manage'),
      headers: headers);

  if (response.statusCode == 200) {
    var x = response.body;
    print(response.body);
    return Data.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Data');
  }
}

class Data {
  Data({
    required this.foundInventoryTypes,
  });
  late final List<FoundInventoryTypes> foundInventoryTypes;

  Data.fromJson(Map<String, dynamic> json) {
    foundInventoryTypes = List.from(json['foundInventoryTypes'])
        .map((e) => FoundInventoryTypes.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['foundInventoryTypes'] =
        foundInventoryTypes.map((e) => e.toJson()).toList();
    return _data;
  }
}

class FoundInventoryTypes {
  FoundInventoryTypes({
    required this.id,
    required this.inventoryName,
    required this.inventoryPrice,
    required this.leastCriticalAmount,
    required this.totalAmount,
  });
  late final int id;
  late final String inventoryName;
  late final int inventoryPrice;
  late final int leastCriticalAmount;
  late final int totalAmount;

  FoundInventoryTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inventoryName = json['inventory_name'];
    inventoryPrice = json['inventory_price'];
    leastCriticalAmount = json['least_critical_amount'];
    totalAmount = json['total_amount'];
    print(inventoryPrice);
    print(totalAmount);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['inventory_name'] = inventoryName;
    _data['inventory_price'] = inventoryPrice;
    _data['least_critical_amount'] = leastCriticalAmount;
    _data['total_amount'] = totalAmount;
    return _data;
  }
}

class getinventory extends StatefulWidget {
  const getinventory({super.key});

  @override
  State<getinventory> createState() => _MyAppState();
}

class _MyAppState extends State<getinventory> {
  late Future<Data> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Get Inventory'),
        ),
        body: Center(
          child: FutureBuilder<Data>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text(snapshot
                              .data!.foundInventoryTypes[0].inventoryName),
                          title: Text(snapshot
                              .data!.foundInventoryTypes[0].inventoryPrice
                              .toString()),
                          subtitle: Text(snapshot
                              .data!.foundInventoryTypes[0].leastCriticalAmount
                              .toString()),
                        ),
                        ListTile(
                          leading: Text(snapshot
                              .data!.foundInventoryTypes[1].inventoryName),
                          title: Text(snapshot
                              .data!.foundInventoryTypes[1].inventoryPrice
                              .toString()),
                          subtitle: Text(snapshot
                              .data!.foundInventoryTypes[1].leastCriticalAmount
                              .toString()),
                        ),
                        ListTile(
                          leading: Text("A"),
                          title: Text("Price 1, "),
                          subtitle: Text("Total Amount in stock: 3, "),
                        )
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                print("Haha");
                return Text('hehe');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
