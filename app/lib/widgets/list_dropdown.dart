import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:family_list/main.dart';
import 'package:family_list/models/state/app_user.dart';
import 'package:family_list/models/state/active_list.dart';
import 'package:family_list/models/api/list_metadata.dart';
import 'package:family_list/models/api/lists_collection.dart';

class ListDropdown extends StatelessWidget {
  final int _activePage;

  ListDropdown(this._activePage);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppUser>(
      builder: (context, user, _) {
        if (user.state == AppState.LOGGED_IN) {
          return FutureBuilder(
            future: ListsCollection.getLists(user.token),
            builder: (context, AsyncSnapshot<List<ListMetadata>> snapshot) {
              if (snapshot.data != null && _activePage != 0) {
                // Create dropdown menu containing all of the family's lists
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
              return Container();
            },
          );
        }
        return LoginButton();
      },
    );
  }
}
