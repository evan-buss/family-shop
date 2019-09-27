import 'dart:async';

import 'package:family_list/models/api/list_item.dart';
import 'package:family_list/util/text_styles.dart';
import 'package:family_list/widgets/family_card_item.dart';
import 'package:family_list/widgets/personal_card_item.dart';
import 'package:family_list/widgets/profile_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:family_list/models/state/app_user.dart';
import 'package:family_list/screens/create_item_screen.dart';
import 'package:family_list/models/state/active_list.dart';
import 'package:family_list/widgets/picture_card.dart';

// PersonalScreen displays the currently signed-in users personal items.
class PersonalScreen extends StatefulWidget {
  PersonalScreen({Key key}) : super(key: key);

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  Future<List<ListItem>> items;

  _PersonalScreenState();

  void _handleDelete(ActiveList list, int index) {
    bool doDelete = true;

    var item = list.items[index]; // Save a copy of the item
    setState(() {
      list.items.removeAt(index); //Remove the item from the list
    });

    // Allow user to undo deletion
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Item removed.'),
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              doDelete = false;
              setState(() {
                if (list.items.length >= index) {
                  list.items
                      .insert(index, item); // Don't delete, re-insert item
                } else {
                  list.items.add(item);
                }
              });
            },
          ),
        ),
      );
    // Wait 5 seconds to actuall delete the item
    Future.delayed(Duration(seconds: 3), () {
      print("delayed running");
      if (doDelete) {
        list.deleteItem(item); // Send request to server
      }
    });
  }

  // Construct a list from the results of the API request
  Widget _listBuilder() {
    return Consumer<ActiveList>(
      builder: (context, list, _) {
        if (list != null) {
          return ListView.builder(
              itemCount: list.items.length,
              itemBuilder: (context, index) {
                return list.items[index].creator.id ==
                        Provider.of<AppUser>(context).userID
                    ? PersonalCardItem(
                        list.items[index], () => _handleDelete(list, index))
                    : FamilyCardItem();
              });
        }
        return Text("no lists found");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pull down to refresh the list
    return RefreshIndicator(
      onRefresh: () {
        Provider.of<ActiveList>(context).reloadList();
        // Have to return some sort of future...
        return Future<String>.value("success");
      },
      child: Consumer<AppUser>(
        builder: (context, user, _) {
          if (user.state == AppState.LOGGED_OUT) {
            return _errorCard("Please Log In", "assets/images/login.png",
                topOffset: 160);
          }
          return Consumer<ActiveList>(
            builder: (context, list, _) {
              if (list.items != null) {
                return _listBuilder();
              } else {
                return _errorCard("Select a list", "assets/images/select.png");
              }
            },
          );
        },
      ),
    );
  }

  // Show an error message with an image asset
  Widget _errorCard(String error, String assetPath, {double topOffset = 110}) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: topOffset),
          child: PictureCard(text: error, assetString: assetPath),
        )
      ],
    );
  }
}
