import 'package:erp_mobile/uipage/login.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';
import 'main_dash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Dashboard());
}

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logOut() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('loggedin', false);
      prefs.remove('mail');
      return Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => LoginPage(),
            transitionDuration: Duration(milliseconds: 200),
          ));
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          centerTitle: true,
          title: const Text("Logged in Successfully"),
        ),
        backgroundColor: Colors.grey[300],
        drawer: MainDrawer(),
        body: Column(
          children: [
            Center(child: DashboardPage()),
            Center(
              child: MaterialButton(
                  child: const Text("Logout"), onPressed: () => logOut()),
            )
          ],
        ));
  }
}
