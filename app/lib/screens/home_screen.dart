import 'package:family_list/screens/first_screen.dart';
import 'package:family_list/screens/overview_screen.dart';
import 'package:flutter/material.dart';

//Home screen should either show the new user screen or a summary screen
class HomeScreen extends StatelessWidget{
  const HomeScreen(this.loggedIn);

  final bool loggedIn;

  @override
  Widget build(BuildContext context) {
    return loggedIn ? OverviewScreen() : FirstScreen();
  }
}
