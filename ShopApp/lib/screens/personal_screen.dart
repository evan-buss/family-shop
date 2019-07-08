import 'dart:convert';

import 'package:family_list/screens/auth_screen.dart';
import 'package:http/http.dart' as http;
import 'package:family_list/models/ListItem.dart';
import 'package:flutter/material.dart';

import 'package:family_list/util/urls.dart';
import 'package:family_list/widgets/picture_card.dart';

class PersonalScreen extends StatefulWidget {
  PersonalScreen({Key key}) : super(key: key);

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  Future<List<ListItem>> items;

  _PersonalScreenState();

  // This seems to get called each time the user swipes to the screen
  @override
  void initState() {
    super.initState();
    items = retrievePersonalItems();
  }

  Future<List<ListItem>> retrievePersonalItems() async {
    final response = await http.get(personalList);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      return jsonResponse
          .map<ListItem>((json) => new ListItem.fromJson(json))
          .toList();
    } else {
      throw Exception("failed to retrieve personal list items");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        items = retrievePersonalItems();
        setState(() => {});
        return Future<String>.value("success");
      },
      child: FutureBuilder<List<ListItem>>(
        future: items,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onLongPress: () async {
                      var sheetController = showBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Card(
                              elevation: 8,
                              child: Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'This is the modal bottom sheet. Slide down to dismiss.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 24.0,
                                        ),
                                      ),
                                      RaisedButton(
                                        child: Text("CLOSE"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  )),
                            );
                          });
                      print(sheetController);
                      sheetController.closed.then((void wow) {
                        print("wow");
                      });
                    },
                    title: Text(snapshot.data[index].title),
                  );
                });
          } else if (snapshot.hasError) {
            return ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 160),
                  child: PictureCard(
                      text: "Connection Error",
                      assetString: "assets/images/connection_error.png"),
                )
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
