import 'package:flutter/material.dart';

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}


// my color #2196F3 lightblue

//         fro example
//   hexStringToColor("CB2B93"),
//   hexStringToColor("9546C4"),
//   hexStringToColor("5E61F4")

//Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [hexStringToColor("CB2B93")],))),