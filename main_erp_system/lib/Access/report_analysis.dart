import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:main_erp_system/utils/bar_chart.dart';
import 'package:main_erp_system/utils/pie_chart.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class reportA extends StatefulWidget {
  const reportA({Key? key}) : super(key: key);

  @override
  State<reportA> createState() => _reportAState();
}

class _reportAState extends State<reportA> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const LocaleText("report_and_anlysiss"),
          bottom: TabBar(
            //labelStyle: TextStyle(font),
            // labelStyle: const TextStyle(fontSize: 20),
            tabs: [
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Text("Pie Chart "),
                    ),
                    Container(
                      child: Icon(Icons.pie_chart_sharp),
                    ),
                  ],
                ),
                height: 35,
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Text("  Graph "),
                    ),
                    Container(
                      child: Icon(Icons.auto_graph),
                    ),
                  ],
                ),
                height: 35,
                //child: const Text('Graph'),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Text("Bar Chart "),
                    ),
                    Container(
                      child: Icon(Icons.bar_chart),
                    ),
                  ],
                ),
                height: 35,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: SingleChildScrollView(
                child: piechart(),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                  //child: StackedBarChart(),
                  ),
            ),
            Center(
              child: Text("bar chart"),
            ),
          ],
        ),
      ),
    );
  }
}
