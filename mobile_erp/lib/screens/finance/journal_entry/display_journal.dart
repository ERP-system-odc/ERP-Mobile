import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'journal_entry.dart';

class JournalEntry {
  JournalEntry({
    required this.status,
    required this.data,
  });
  late final int status;
  late final List<Data> data;

  JournalEntry.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.createdAt,
    required this.account,
    required this.debit,
    required this.credit,
  });
  late final int id;
  late final String createdAt;
  late final String account;
  late final int debit;
  late final int credit;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    account = json['account'];
    debit = json['debit'];
    credit = json['credit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_at'] = createdAt;
    _data['account'] = account;
    _data['debit'] = debit;
    _data['credit'] = credit;
    return _data;
  }
}

Future<JournalEntry> fetchJournal(String text) async {
  final prefsTr = await SharedPreferences.getInstance();
  final tokenn = prefsTr.getString('token');
  print("_------------------");

  var headers = {
    'Authorization': 'Bearer $tokenn',
    'Content-Type': 'application/json',
  };
  final response = await http.get(
      Uri.parse('http://localhost:5000/api/journalEntry/manage/$text'),
      headers: headers);

  if (response.statusCode == 200) {
    print(response.body);
    return JournalEntry.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Data');
  }
}

class GetJournal extends StatefulWidget {
  String text;
  GetJournal({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<GetJournal> createState() => _GetJournalState(text);
}

class _GetJournalState extends State<GetJournal> {
  String text;
  _GetJournalState(this.text);
  late Future<JournalEntry> futureJournals;

  void initState() {
    super.initState();
    futureJournals = fetchJournal(text);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Display Expenses"),
        ),
        body: Center(
          child: FutureBuilder<JournalEntry>(
            future: futureJournals,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            child: Column(
                              children: [
                                Text(snapshot.data!.data[index].createdAt),
                                Text(snapshot.data!.data[index].account
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
