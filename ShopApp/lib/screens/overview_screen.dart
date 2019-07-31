import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
        onPressed: () async {
          final storage = FlutterSecureStorage();
          await storage.delete(key: "token");
        },
      )
    ]);
  }
}
