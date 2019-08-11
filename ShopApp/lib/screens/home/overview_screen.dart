import 'package:family_list/models/app_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverviewScreen extends StatelessWidget {
  OverviewScreen();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      Consumer<AppUser>(
        builder: (context, user, _) {
          return Text(
            "Welcome back, ${user.username}",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "ProductSans",
                fontWeight: FontWeight.bold,
                fontSize: 32),
          );
        },
      ),
    ]);
  }
}
