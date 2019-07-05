import 'package:flutter/material.dart';

class OverviewScreen extends StatelessWidget {
  OverviewScreen();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
      Text(
        "Welcome back, Evan",
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: "ProductSans",
            fontWeight: FontWeight.bold,
            fontSize: 32),
      ),
    ]);
  }
}
