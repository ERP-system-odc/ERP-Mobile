import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Products {
  Products({
    required this.status,
    required this.foundProduct,
  });
  late final int status;
  late final List<FoundProduct> foundProduct;

  Products.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    foundProduct = List.from(json['foundProduct'])
        .map((e) => FoundProduct.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['foundProduct'] = foundProduct.map((e) => e.toJson()).toList();
    return _data;
  }
}

class FoundProduct {
  FoundProduct({
    required this.id,
    required this.productName,
    required this.productQuantity,
    required this.productSellingPrice,
    required this.productInventoryCost,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String productName;
  late final int productQuantity;
  late final int productSellingPrice;
  late final int productInventoryCost;
  late final String createdAt;
  late final String updatedAt;

  FoundProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productQuantity = json['product_quantity'];
    productSellingPrice = json['product_selling_price'];
    productInventoryCost = json['product_inventory_cost'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product_name'] = productName;
    _data['product_quantity'] = productQuantity;
    _data['product_selling_price'] = productSellingPrice;
    _data['product_inventory_cost'] = productInventoryCost;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

Future<Products> fetchProducts() async {
  final prefsTr = await SharedPreferences.getInstance();
  final tokenn = prefsTr.getString('token');
  print("_------------------");

  var headers = {
    'Authorization': 'Bearer $tokenn',
    'Content-Type': 'application/json',
  };
  final response = await http.get(
      Uri.parse('http://localhost:5000/api/product/manage'),
      headers: headers);

  if (response.statusCode == 200) {
    var x = response.body;
    print(response.body);
    return Products.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Data');
  }
}

class ShowProducts extends StatefulWidget {
  // const ShowProducts({Key? key}) : super(key: key);

  @override
  State<ShowProducts> createState() => _ShowProductsState();
}

class _ShowProductsState extends State<ShowProducts> {
  late Future<Products> fetchProduct;
  @override
  void initState() {
    super.initState();
    fetchProduct = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF5048E5),
          title: const Text('Inventories '),
        ),
        body: Center(
          child: FutureBuilder<Products>(
            future: fetchProduct,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.foundProduct.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: ListTile(
                                  shape: const BeveledRectangleBorder(
                                      side: BorderSide(
                                          color: Color(0xFF5048E5),
                                          strokeAlign: StrokeAlign.outside)),
                                  leading: Text(
                                      "Product Name: ${snapshot.data!.foundProduct[index].productName}"),
                                  title: Text(
                                      "Quantity: ${snapshot.data!.foundProduct[index].productQuantity.toString()}"),
                                  subtitle: Text(
                                      "Inventory Cost ${snapshot.data!.foundProduct[index].productInventoryCost.toString()}"),
                                  trailing: IconButton(
                                      onPressed: () {
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.edit))),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    });
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
