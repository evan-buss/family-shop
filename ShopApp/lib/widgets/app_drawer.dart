import 'package:family_list/models/AppUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

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
          child: Consumer<AppUser>(
            builder: (context, user, _) {
              return Text(
                user.state == AppState.LOGGED_IN
                    ? "Greetings, " + user.username.split(" ")[0]
                    : "Please Sign In",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "ProductSans",
                    fontSize: 30),
              );
            },
          ),
          decoration: BoxDecoration(color: Colors.blue),
        ),
        ListTile(
          title: Text("Family"),
          leading: Icon(Icons.people),
        ),
        // Consumer<AppUser>(
        //   builder: (context, user, _) {},
        // ),
        ListTile(
          title: Text("Settings"),
          leading: Icon(Icons.settings),
        ),
        ListTile(
          title: Text("Log Out"),
          leading: Icon(Icons.exit_to_app),
          onTap: () {
            Provider.of<AppUser>(context, listen: true).logOut();
          },
        ),
      ],
    );
  }
}
