import 'package:flutter/material.dart';
import 'package:pexels_api_flutter_ui/os/mobile/mobile.dart';

class MyDrawer extends StatelessWidget {

  Color? color;
  String? imageUrl;

  MyDrawer({
    Key? key,
    this.color,
    this.imageUrl,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: color
                ),
              accountName: const Text("Pexels"),
              accountEmail:const Text("pexels@gmail.com"),
              currentAccountPicture:  CircleAvatar(
                backgroundImage: NetworkImage(imageUrl!),
              )),
            
            ListTile(
              title: const Text("Home"),
              leading:const Icon(Icons.home),
              onTap: (){
               Navigator.of(context)
               .push(MaterialPageRoute(builder: (context)=>const MobileBody(
                key: ObjectKey("Home"),
               )));
              },
            ),       
            const ListTile(
              title: Text("Dashboard"),
              leading: Icon(Icons.dashboard),
              onTap: null,
            ),       
            const ListTile(
              title: Text("Call"),
              leading: Icon(Icons.call),
              onTap: null,
            ),  
           const ListTile(
              title: Text("setting"),
              leading: Icon(Icons.settings),
              onTap: null,
            ), 
           const ListTile(
              title: Text("Share"),
              leading: Icon(Icons.share),
              onTap: null,
            ),   
        ],
      ),
    );
  }
}
