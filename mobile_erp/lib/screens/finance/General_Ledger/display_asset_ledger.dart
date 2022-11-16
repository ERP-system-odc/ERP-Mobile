import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GeneralLedger {
  GeneralLedger({
    required this.status,
    required this.assetGeneralLedger,
    required this.expenseGeneralLedger,
    required this.revenueGeneralLedger,
    required this.liabilityGeneralLedger,
    required this.capitalGeneralLedger,
  });
  late final int status;
  late final List<AssetGeneralLedger> assetGeneralLedger;
  late final List<ExpenseGeneralLedger> expenseGeneralLedger;
  late final List<RevenueGeneralLedger> revenueGeneralLedger;
  late final List<dynamic> liabilityGeneralLedger;
  late final List<CapitalGeneralLedger> capitalGeneralLedger;

  GeneralLedger.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    assetGeneralLedger = List.from(json['asset_general_ledger'])
        .map((e) => AssetGeneralLedger.fromJson(e))
        .toList();
    expenseGeneralLedger = List.from(json['expense_general_ledger'])
        .map((e) => ExpenseGeneralLedger.fromJson(e))
        .toList();
    revenueGeneralLedger = List.from(json['revenue_general_ledger'])
        .map((e) => RevenueGeneralLedger.fromJson(e))
        .toList();
    liabilityGeneralLedger =
        List.castFrom<dynamic, dynamic>(json['liabilityGeneralLedger']);
    capitalGeneralLedger = List.from(json['capitalGeneralLedger'])
        .map((e) => CapitalGeneralLedger.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['asset_general_ledger'] =
        assetGeneralLedger.map((e) => e.toJson()).toList();
    _data['expense_general_ledger'] =
        expenseGeneralLedger.map((e) => e.toJson()).toList();
    _data['revenue_general_ledger'] =
        revenueGeneralLedger.map((e) => e.toJson()).toList();
    _data['liabilityGeneralLedger'] = liabilityGeneralLedger;
    _data['capitalGeneralLedger'] =
        capitalGeneralLedger.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AssetGeneralLedger {
  AssetGeneralLedger({
    required this.transactionDate,
    required this.description,
    required this.debit,
    required this.credit,
    required this.balanceDebit,
    required this.balanceCredit,
  });
  late final String transactionDate;
  late final String description;
  late final int debit;
  late final int credit;
  late final int balanceDebit;
  late final int balanceCredit;

  AssetGeneralLedger.fromJson(Map<String, dynamic> json) {
    transactionDate = json['transaction_date'];
    description = json['description'];
    debit = json['debit'];
    credit = json['credit'];
    balanceDebit = json['balance_debit'];
    balanceCredit = json['balance_credit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['transaction_date'] = transactionDate;
    _data['description'] = description;
    _data['debit'] = debit;
    _data['credit'] = credit;
    _data['balance_debit'] = balanceDebit;
    _data['balance_credit'] = balanceCredit;
    return _data;
  }
}

class ExpenseGeneralLedger {
  ExpenseGeneralLedger({
    required this.transactionDate,
    required this.description,
    required this.debit,
    required this.credit,
    required this.balanceDebit,
    required this.balanceCredit,
  });
  late final String transactionDate;
  late final String description;
  late final int debit;
  late final int credit;
  late final int balanceDebit;
  late final int balanceCredit;

  ExpenseGeneralLedger.fromJson(Map<String, dynamic> json) {
    transactionDate = json['transaction_date'];
    description = json['description'];
    debit = json['debit'];
    credit = json['credit'];
    balanceDebit = json['balance_debit'];
    balanceCredit = json['balance_credit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['transaction_date'] = transactionDate;
    _data['description'] = description;
    _data['debit'] = debit;
    _data['credit'] = credit;
    _data['balance_debit'] = balanceDebit;
    _data['balance_credit'] = balanceCredit;
    return _data;
  }
}

class RevenueGeneralLedger {
  RevenueGeneralLedger({
    required this.transactionDate,
    required this.description,
    required this.debit,
    required this.credit,
    required this.balanceCredit,
    required this.balanceDebit,
  });
  late final String transactionDate;
  late final String description;
  late final int debit;
  late final int credit;
  late final int balanceCredit;
  late final int balanceDebit;

  RevenueGeneralLedger.fromJson(Map<String, dynamic> json) {
    transactionDate = json['transaction_date'];
    description = json['description'];
    debit = json['debit'];
    credit = json['credit'];
    balanceCredit = json['balance_credit'];
    balanceDebit = json['balance_debit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['transaction_date'] = transactionDate;
    _data['description'] = description;
    _data['debit'] = debit;
    _data['credit'] = credit;
    _data['balance_credit'] = balanceCredit;
    _data['balance_debit'] = balanceDebit;
    return _data;
  }
}

class CapitalGeneralLedger {
  CapitalGeneralLedger({
    required this.transactionDate,
    required this.description,
    required this.debit,
    required this.credit,
    required this.balanceCredit,
    required this.balanceDebit,
  });
  late final String transactionDate;
  late final String description;
  late final int debit;
  late final int credit;
  late final int balanceCredit;
  late final int balanceDebit;

  CapitalGeneralLedger.fromJson(Map<String, dynamic> json) {
    transactionDate = json['transaction_date'];
    description = json['description'];
    debit = json['debit'];
    credit = json['credit'];
    balanceCredit = json['balance_credit'];
    balanceDebit = json['balance_debit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['transaction_date'] = transactionDate;
    _data['description'] = description;
    _data['debit'] = debit;
    _data['credit'] = credit;
    _data['balance_credit'] = balanceCredit;
    _data['balance_debit'] = balanceDebit;
    return _data;
  }
}

class GetLedger extends StatefulWidget {
  String text;
  String text2;
  GetLedger({
    Key? key,
    required this.text,
    required this.text2,
  }) : super(key: key);

  @override
  State<GetLedger> createState() => _GetLedgerState(text, text2);
}

class _GetLedgerState extends State<GetLedger> {
  late Future<GeneralLedger> ledgerData;
  String text;
  String text2;
  _GetLedgerState(this.text, this.text2);
  void initState() {
    ledgerData = fetchLedger(text, text2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Display General Ledger"),
      ),
      body: Center(
        child: FutureBuilder<GeneralLedger>(
            future: ledgerData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.assetGeneralLedger.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            shape: const BeveledRectangleBorder(
                                side: BorderSide(
                                    color: Color(0xFF5048E5),
                                    strokeAlign: StrokeAlign.outside)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    'Description: ${snapshot.data!.assetGeneralLedger[index].description}'),
                                Text(
                                    'Date: ${snapshot.data!.assetGeneralLedger[index].transactionDate}'),
                                Text(
                                    'Balance Credit: ${snapshot.data!.assetGeneralLedger[index].balanceCredit}'),
                                Text(
                                    'Balance Debit: ${snapshot.data!.assetGeneralLedger[index].balanceDebit}'),
                                Text(
                                    'Credit: ${snapshot.data!.assetGeneralLedger[index].credit.toString()}'),
                                Text(
                                    'debit: ${snapshot.data!.assetGeneralLedger[index].debit.toString()}'),
                                //  Text('Asset-Balance: ${snapshot.data!.capitalGeneralLedger
                                //      .toString()}'),
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
            }),
      ),
    );
  }

  Future<GeneralLedger> fetchLedger(String text, text2) async {
    final prefsTr = await SharedPreferences.getInstance();
    final tokenn = prefsTr.getString('token');
    print("_------------------");

    var headers = {
      'Authorization': 'Bearer $tokenn',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
        Uri.parse(
            'http://localhost:5000/api/generalLedger/manage/$text/$text2'),
        headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      return GeneralLedger.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
