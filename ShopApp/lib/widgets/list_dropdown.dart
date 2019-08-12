import 'package:family_list/main.dart';
import 'package:family_list/models/app_user.dart';
import 'package:family_list/models/list.dart';
import 'package:family_list/models/list_meta.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppUser>(
      builder: (context, user, _) {
        if (user.state == AppState.LOGGED_IN) {
          return FutureBuilder(
            future: ListsCollection.getLists(user.token),
            builder: (context, AsyncSnapshot<List<ListMetadata>> snapshot) {
              if (snapshot.data != null) {
                return PopupMenuButton<ListMetadata>(
                    enabled: snapshot.data.length > 0,
                    icon: Icon(Icons.list),
                    tooltip: "Family's Lists",
                    onSelected: (selection) {
                      Provider.of<ActiveList>(context)
                          .loadList(selection, user.token);
                    },
                    itemBuilder: (BuildContext context) {
                      return snapshot.data.map<PopupMenuItem<ListMetadata>>(
                          (ListMetadata list) {
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
