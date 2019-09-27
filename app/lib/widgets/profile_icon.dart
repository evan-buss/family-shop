import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final String name;
  final double x, y;

  ProfileIcon({this.name, this.x = 50, this.y = 50});

  static String getInitials(String name) {
    return name.split(" ").take(2).map((f) => f.substring(0, 1)).join();
  }

  @override
  Widget build(BuildContext context) {
    if (this.name != null) {
      return Chip(
        avatar: CircleAvatar(
          backgroundColor: Theme.of(context).accentColor,
          child: Text(
            getInitials(name),
          ),
        ),
        label: Text(name),
      );
    }
    return Chip(
      avatar: CircleAvatar(
          backgroundImage: NetworkImage("https://i.imgur.com/BoN9kdC.png")),
      label: Text('Ah Shit'),
    );
  }
}
