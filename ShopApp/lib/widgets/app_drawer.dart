import 'dart:convert';

import 'package:family_list/models/app_user.dart';
import 'package:family_list/models/family.dart';
import 'package:family_list/util/urls.dart';
import 'package:family_list/widgets/profile_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class FamilyMember {
  int userID;
  String name;

  FamilyMember({this.userID, this.name});

  factory FamilyMember.fromJson(Map<String, dynamic> json) {
    return FamilyMember(
        userID: int.parse(json["userID"]), name: json["username"]);
  }
}

// App Drawer that provides quick account information
class AppDrawer extends StatelessWidget {
  Future<List<Widget>> getFamilyMembers(BuildContext context) async {
    // Get the token from App State
    var token = Provider.of<AppUser>(context).token;
    // Get a json array of member objects
    var response = await http
        .get(familyMembersURL, headers: {"authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      return data
          .map<Widget>((f) => ProfileIcon(x: 40, y: 40, name: f["username"]))
          .toList();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppUser>(
      builder: (context, user, child) {
        return ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                user.state == AppState.LOGGED_IN
                    ? "Greetings, " + user.username.split(" ")[0]
                    : "Please Sign In",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "ProductSans",
                    fontSize: 30),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text("Family Members"),
              leading: Icon(Icons.people),
            ),
            user.state == AppState.LOGGED_IN
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: getFamilyMembers(context),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            spacing: 8,
                            runSpacing: 8,
                            children: snapshot.data,
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  )
                : Container(),
            child
          ],
        );
      },
      child: Column(
        children: <Widget>[
          Divider(),
          ListTile(
            title: Text("Settings"),
            leading: Icon(Icons.settings),
          ),
          Divider(),
          ListTile(
            title: Text("Log Out"),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              Provider.of<AppUser>(context, listen: true).logOut();
            },
          ),
        ],
      ),
    );
  }
}
