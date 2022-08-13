import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {



  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: const <Widget>[
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              accountName: Text("Aditya Sharma"),
              accountEmail: Text("adsharmavashishtha@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.pink,
              )),
            ListTile(
              title: Text("Home"),
              leading: Icon(Icons.home),
              onTap: null,
            ),  
            ListTile(
              title: Text("Dashboard"),
              leading: Icon(Icons.dashboard),
              onTap: null,
            ),       
            ListTile(
              title: Text("Call"),
              leading: Icon(Icons.call),
              onTap: null,
            ),  
            ListTile(
              title: Text("setting"),
              leading: Icon(Icons.settings),
              onTap: null,
            ), 
            ListTile(
              title: Text("Share"),
              leading: Icon(Icons.share),
              onTap: null,
            ),   
        ],
      ),
    );
  }
}
