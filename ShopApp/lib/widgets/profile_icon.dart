import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileIcon extends StatelessWidget {
  final String name;
  final double x, y;

  ProfileIcon({this.name, this.x = 50, this.y = 50});

  String getInitials() {
    return name.split(" ").take(2).map((f) => f.substring(0, 1)).join();
  }

  @override
  Widget build(BuildContext context) {
    if (this.name != null) {
      return Chip(
        avatar: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            getInitials(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        label: Text(name),
      );
    }
    // return CircleAvatar(
    //   backgroundImage: NetworkImage("https://i.imgur.com/BoN9kdC.png"),

    // );

    return Chip(
      avatar: CircleAvatar(
          backgroundImage: NetworkImage("https://i.imgur.com/BoN9kdC.png")),
      label: Text('Ah Shit'),
    );
  }
}
