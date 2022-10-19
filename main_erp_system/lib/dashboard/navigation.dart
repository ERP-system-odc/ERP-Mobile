import 'package:flutter/material.dart';

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
                child: Image.asset(
                  "images/pp.png",
                  fit: BoxFit.cover,
                  height: 90,
                  width: 90,
                ),
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
            onTap: () => print('Fav'),
          ),
          ListTile(
            leading: Icon(Icons.logout_sharp),
            title: Text('Log Out'),
            onTap: () => print('Fav'),
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete Account'),
            onTap: () => print('Fav'),
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
