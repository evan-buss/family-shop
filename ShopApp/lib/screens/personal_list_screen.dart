import 'dart:async';

import 'package:family_list/models/app_user.dart';
import 'package:flutter/rendering.dart';
import 'package:family_list/models/list.dart';
import 'package:flutter/material.dart';

import 'package:family_list/widgets/picture_card.dart';
import 'package:provider/provider.dart';

// PersonalScreen displays the currently signed-in users personal items.
class PersonalScreen extends StatefulWidget {
  PersonalScreen({Key key}) : super(key: key);

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  Future<List<ListItem>> items;

  _PersonalScreenState();

// return ListView(
//   children: <Widget>[
//     Padding(
//       padding: EdgeInsets.only(top: 160),
//       child: PictureCard(
//           text: "Please Log In",
//           assetString: "assets/images/connection_error.png"),
//     )
//   ],
// );

  // Construct a list from the results of the API request
  Widget _listBuilder() {
    return Consumer<ActiveList>(
      builder: (context, list, _) {
        if (list != null) {
          return ListView.builder(
              itemCount: list.items.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ObjectKey(list.items[index]),
                  background: Container(
                    color: Colors.red,
                  ),
                  onDismissed: (direction) {
                    bool doDelete = true;

                    var item = list.items[index]; // Save a copy of the item
                    setState(() {
                      list.items
                          .removeAt(index); //Remove the item from the list
                    });

                    // Allow user to undo deletion
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Item removed.'),
                        duration: Duration(seconds: 5),
                        action: SnackBarAction(
                          label: 'Undo',
                          textColor: Colors.blue,
                          onPressed: () {
                            doDelete = false;
                            setState(() {
                              list.items.insert(
                                  index, item); // Don't delete, re-insert item
                            });
                          },
                        ),
                      ),
                    );
                    // Wait 5 seconds to actuall delete the item
                    Future.delayed(Duration(seconds: 5), () {
                      print("delayed running");
                      if (doDelete) {
                        list.deleteItem(
                            list.items[index]); // Send request to server
                      }
                    });
                  },
                  child: ListTile(
                    onTap: () {
                      //  TODO: Show details/edit screen
                    },
                    title: Text(list.items[index].title),
                    subtitle: Text(list.items[index].description),
                  ),
                );
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
      child: Consumer<ActiveList>(
        builder: (context, list, _) {
          if (list.items != null) {
            return _listBuilder();
          } else {
            return ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 160),
                  child: PictureCard(
                      text: "Select a list to view it",
                      assetString: "assets/images/connection_error.png"),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
