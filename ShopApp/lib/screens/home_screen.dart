import 'package:family_list/models/AppUser.dart';
import 'package:flutter/material.dart';

import 'package:family_list/screens/first_screen.dart';
import 'package:family_list/screens/overview_screen.dart';

import 'package:provider/provider.dart';

// Home Screen is a facade that either shows the new user login/sign-up or the
// home page summary screen.
class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppUser>(
      builder: (context, user, child) {
        if (user.state == AppState.LOGGED_IN) {
          return OverviewScreen();
        }
        return FirstScreen();
      },
    );
  }
}
