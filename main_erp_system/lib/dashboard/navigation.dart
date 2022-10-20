import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_erp_system/Auth/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('mintesnot'),
            accountEmail: Text('"spacepro@gmail.com"'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(

                  // child: Image.asset(
                  //   "images/pp.png",
                  //   fit: BoxFit.contain,
                  //   height: 90,
                  //   width: 90,
                  // ),
                  ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.analytics),
            title: Text('Report & Analysis'),
            onTap: () => print('Fav'),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add'),
            onTap: () => print('add'),
          ),
          ListTile(
            //tileColor: Colors.amber,
            //textColor: Color.fromARGB(255, 33, 150, 243),
            leading: Icon(Icons.language),
            title: Text('Language'),
            onTap: () => print('language'),
          ),
          ListTile(
            leading: Icon(Icons.logout_sharp),
            title: Text('Log Out'),
            onTap: () => {
              ShowAlertDialog(context),
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete Account'),
            onTap: () => {
              ShowAlertDialogtwo(context),
            },
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () => print('Fav'),
          ),
          ListTile(
            leading: Icon(Icons.send),
            title: Text('Send'),
            onTap: () => print('Fav'),
          ),
          ListTile(
            leading: Icon(Icons.new_releases),
            title: Text("What's is new"),
            onTap: () => print('Fav'),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About Us'),
            onTap: () => print('Fav'),
          ),
        ],
      ),
    );
  }
}

ShowAlertDialogtwo(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text("CANCLE"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("DELETE"),
    onPressed: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString('email');

      try {
        final myBody = ({
          'email': email,
        });

        Response response = await delete(
            Uri.parse('http://localhost:5000/api/auth/signin/users/${'id'}'),
            body: myBody);
        try {
          //print(jsonDecode(response.body.toString()));
          if (response.statusCode == 200) {
            print('you are loged in');
          } else {
            final snackBar = SnackBar(
              content: Text(['message'].toString().trim()),
            );
          }
        } catch (e) {
          print(e.toString());
        }
      } catch (e) {
        print(e.toString());
      }

      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Are you sure!"),
    content: Text(
        "Deleting this account will result in completely removing your account from the system and you won't be able to access the app with this account again"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

ShowAlertDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text("NO"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("YES"),
    onPressed: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('email');
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Signing Out!"),
    content: Text("Are you sure you want to Logout?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
