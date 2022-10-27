import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Post> fetchAlbum() async {
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
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("AAAA");
    print(response.body);
    var parsed = (response.body);
    return Post.fromJson(jsonDecode(parsed));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
class Post {
  String? inventoryName;
  String? inventoryPrice;
  String? leastCriticalAmount;
  String? totalAmount;

  Post(
      {required this.inventoryName,
      required this.inventoryPrice,
      required this.leastCriticalAmount,
      required this.totalAmount});

  Post.fromJson(Map<String, dynamic> json) {
    inventoryName = json['data'][0]['inventory_name'].toString();
    inventoryPrice = json['data']['inventory_price'].toString();
    leastCriticalAmount = json['data']['least_critical_amount'].toString();
    totalAmount = json['data']['total_amount'].toString();
    print(inventoryName);
  }
}

class getinventory extends StatefulWidget {
  const getinventory({super.key});

  @override
  State<getinventory> createState() => _MyAppState();
}

class _MyAppState extends State<getinventory> {
  late Future<Post> futureAlbum;

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
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text("Hello");
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text('${snapshot.error}');
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
