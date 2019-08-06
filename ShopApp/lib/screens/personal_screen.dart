import 'dart:async';
import 'dart:convert';

import 'package:family_list/util/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:family_list/models/ListItem.dart';
import 'package:flutter/material.dart';

import 'package:family_list/util/urls.dart';
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

  // When the view is created, retrieve the items
  @override
  void initState() {
    super.initState();
    items = retrievePersonalItems();
  }

  // Retrieve the items associated with the logged in app user
  Future<List<ListItem>> retrievePersonalItems() async {
    print("refresh");
    var response;
    var token = await getAuthToken();
    try {
      response = await http.get(personalListURL, headers: {
        "Authorization": token
      }).timeout(const Duration(seconds: 2));
    } on TimeoutException catch (_) {
      throw Exception("response timeout");
    }

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      return jsonResponse
          .map<ListItem>((json) => new ListItem.fromJson(json))
          .toList();
    } else {
      throw Exception("failed to retrieve personal list items");
    }
  }

  // Details bottom card that shows on long press of an item
  Widget _itemCard(BuildContext context) {
    return Card(
      elevation: 4,
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
  }

// Construct a list from the results of the API request
  Widget _listBuilder(dynamic snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return ListTile(
            onLongPress: () {},
            onTap: () async {
              var sheetController = showBottomSheet(
                  context: context,
                  elevation: 200.0,
                  builder: (BuildContext context) {
                    return _itemCard(context);
                  });
              print(sheetController);
              sheetController.closed.then((void wow) {
                print("wow");
              });
            },
            title: Text(snapshot.data[index].title),
            subtitle: Text(snapshot.data[index].description),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // Pull down to refresh the list
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
            return _listBuilder(snapshot);
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
