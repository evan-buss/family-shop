import 'package:family_list/main.dart';
import 'package:family_list/models/AppUser.dart';
import 'package:family_list/models/ListMeta.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppUser>(
      builder: (context, user, _) {
        if (user.state == AppState.LOGGED_IN) {
          return FutureBuilder(
            future: UserLists.getLists(user.token),
            builder: (context, AsyncSnapshot<List<ListsMetadata>> snapshot) {
              if (snapshot.data != null) {
                return PopupMenuButton<ListsMetadata>(
                    icon: Icon(Icons.list),
                    tooltip: "Family's Lists",
                    itemBuilder: (BuildContext context) {
                      return snapshot.data.map<PopupMenuItem<ListsMetadata>>(
                          (ListsMetadata list) {
                        return PopupMenuItem(
                          value: list,
                          child: Text(list.title),
                        );
                      }).toList();
                    });
              }
              return LoginButton();
            },
          );
        }
        return LoginButton();
      },
    );
  }
}