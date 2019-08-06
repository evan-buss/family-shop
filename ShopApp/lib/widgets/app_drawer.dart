import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// App Drawer that provides quick account information
class AppDrawer extends StatelessWidget {
  AppDrawer();

// Icon
// Name
// Family
// ------------
// *family names*
// ------------
// Log out
// Settings

  Future<String> getName() async {
    final storage = FlutterSecureStorage();
    var name = await storage.read(key: "username");
    name = name.split(" ")[0];
    return "Greetings, " + name;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: FutureBuilder<String>(
              future: getName(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Text(
                    snapshot.data,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "ProductSans",
                        fontSize: 30),
                  );
                }
                return Text(
                  "Please Sign In",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "ProductSans",
                      fontSize: 30),
                );
              }),
          decoration: BoxDecoration(color: Colors.blue),
        ),
        ListTile(
          title: Text("Family"),
        ),
        ListTile(
          title: Text("Log Out"),
        ),
        ListTile(
          title: Text("Settings"),
        ),
      ],
    );
  }
}
