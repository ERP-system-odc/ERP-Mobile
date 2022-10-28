import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class piechart extends StatefulWidget {
  const piechart({Key? key}) : super(key: key);

  @override
  State<piechart> createState() => _piechartState();
}

class _piechartState extends State<piechart> {
  Map<String, double> dataMap = {
    "Progress": 18.47,
    "Capital": 15.70,
    "others": 5.25,
    "Expense": 3.51,
    "Total Profit": 3.83,
  };
  List<Color> colorList = [
    const Color(0xFF5048E5),
    Color.fromARGB(255, 246, 223, 16),
    Color.fromARGB(255, 18, 244, 48),
    Color.fromARGB(255, 244, 42, 31),
    Color.fromARGB(255, 243, 130, 30)
  ];
  // final gradientList = <List<Color>>[
  //   [
  //     Color.fromRGBO(223, 250, 92, 1),
  //     Color.fromARGB(255, 11, 11, 236),
  //   ],
  //   [
  //     Color.fromRGBO(129, 182, 205, 1),
  //     Color.fromRGBO(91, 253, 199, 1),
  //   ],
  //   [
  //     Color.fromRGBO(175, 63, 62, 1.0),
  //     Color.fromRGBO(254, 154, 92, 1),
  //   ]
  // ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.fromLTRB(12, 40, 5, 12),
            child: PieChart(
              dataMap: dataMap,
              colorList: colorList,
              chartRadius: MediaQuery.of(context).size.width / 2,
              centerText: "ERP",
              ringStrokeWidth: 24,
              animationDuration: const Duration(seconds: 6),
              chartValuesOptions: const ChartValuesOptions(
                showChartValues: true,
                showChartValuesOutside: true,
                showChartValuesInPercentage: true,
                showChartValueBackground: false,
              ),
              legendOptions: const LegendOptions(
                  showLegends: true,
                  legendShape: BoxShape.rectangle,
                  legendTextStyle: TextStyle(fontSize: 15),
                  legendPosition: LegendPosition.bottom,
                  showLegendsInRow: true),
              //gradientList: gradientList,
            ),
          ),
        ),
      ],
    );
  }
}
