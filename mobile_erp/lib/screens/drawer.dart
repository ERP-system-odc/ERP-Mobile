import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[300],
      child: Column(
        children: const [
          UserAccountsDrawerHeader(
            accountName: Text("Abenezer Teshome"),
            accountEmail: Text("abteshome321@gmail.com"),
            currentAccountPicture: CircleAvatar(),
          ),
          DrawerHeader(child: Icon(Icons.fire_truck_rounded)),
          ListTile(
            hoverColor: Colors.black,
            leading: Icon(Icons.pan_tool_sharp),
            title: Text("I N V E N T O R Y"),
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text("F I N A N C E S"),
            hoverColor: Colors.black,
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("E M P L O Y E E"),
            hoverColor: Colors.black,
          ),
          ListTile(
            leading: Icon(Icons.bubble_chart),
            title: Text(
              "L O G O U T",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
