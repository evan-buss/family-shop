import 'package:flutter/cupertino.dart';
import 'package:family_list/screens/home_screen.dart';
import 'package:family_list/screens/personal_screen.dart';

class Routes {
  static var routes = <String, WidgetBuilder> {
    "/home": (BuildContext context) => new HomeScreen(false),
    "/personal": (BuildContext context) => new PersonalScreen(),
  };
}