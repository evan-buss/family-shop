import 'package:family_list/models/AppUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverviewScreen extends StatelessWidget {
  OverviewScreen();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      Text(
        "Welcome back, Evan",
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: "ProductSans",
            fontWeight: FontWeight.bold,
            fontSize: 32),
      ),
      RaisedButton(
        child: Text("Log Out"),
        onPressed: () {
          Provider.of<AppUser>(context, listen: true).logOut();
        },
      )
    ]);
  }
}
