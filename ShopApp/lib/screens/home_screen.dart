import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:family_list/screens/first_screen.dart';
import 'package:family_list/screens/overview_screen.dart';

import 'package:family_list/redux/state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Home Screen is a facade that either shows the new user login/sign-up or the
// home page summary screen.
class HomeScreen extends StatelessWidget {
  const HomeScreen();

  // final bool loggedIn;

  Future<bool> _isLoggedIn() async {
    final storage = FlutterSecureStorage();
    var token = await storage.read(key: "token");
    if (token == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // final store = StoreProvider.of<AppState>(context);
    // return store.state.loggedIn ? OverviewScreen() : FirstScreen();

    return FutureBuilder<bool>(
        future: _isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return OverviewScreen();
          }
          return FirstScreen();
        });
  }
}
