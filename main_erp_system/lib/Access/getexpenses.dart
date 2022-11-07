import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Expense> fetchExpense() async {
  final prefsTr = await SharedPreferences.getInstance();
  final tokenn = prefsTr.getString('token');
  print("_------------------");

  var headers = {
    'Authorization': 'Bearer $tokenn',
    'Content-Type': 'application/json',
  };
  final response = await http.get(
      Uri.parse('http://localhost:5000/api/expense/manage'),
      headers: headers);

  if (response.statusCode == 200) {
    var x = response.body;
    print(response.body);
    return Expense.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Data');
  }
}

class Expense {
  Expense({
    required this.status,
    required this.foundExpense,
  });
  late final int status;
  late final List<FoundExpense> foundExpense;

  Expense.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    foundExpense = List.from(json['foundExpense'])
        .map((e) => FoundExpense.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['foundExpense'] = foundExpense.map((e) => e.toJson()).toList();
    return _data;
  }
}

class FoundExpense {
  FoundExpense({
    required this.id,
    required this.expenseName,
    required this.expenseAmount,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String expenseName;
  late final int expenseAmount;
  late final String createdAt;
  late final String updatedAt;

  FoundExpense.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expenseName = json['expense_name'];
    expenseAmount = json['expense_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['expense_name'] = expenseName;
    _data['expense_amount'] = expenseAmount;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class GetExpense extends StatefulWidget {
  const GetExpense({Key? key}) : super(key: key);

  @override
  State<GetExpense> createState() => _GetExpenseState();
}

class _GetExpenseState extends State<GetExpense> {
  late Future<Expense> futureExpenses;
  void initState() {
    super.initState();
    futureExpenses = fetchExpense();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: FutureBuilder<Expense>(
            future: futureExpenses,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.foundExpense.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            child: Column(
                              children: [
                                Text(snapshot
                                    .data!.foundExpense[index].expenseName),
                                Text(snapshot
                                    .data!.foundExpense[index].expenseAmount
                                    .toString())
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                print(snapshot.error);
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
