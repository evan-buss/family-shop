import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:family_list/screens/first_screen.dart';
import 'package:family_list/screens/overview_screen.dart';

import 'package:family_list/redux/state.dart';

// Home Screen is a facade that either shows the new user login/sign-up or the
// home page summary screen.
class HomeScreen extends StatelessWidget{
  const HomeScreen();

  // final bool loggedIn;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    return store.state.loggedIn ? OverviewScreen() : FirstScreen();
  }
}
