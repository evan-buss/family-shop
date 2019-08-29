import 'dart:ui';

import 'package:family_list/models/app_user.dart';
import 'package:family_list/models/list.dart';
import 'package:family_list/models/list_meta.dart';
import 'package:family_list/util/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateListModal extends StatefulWidget {
  @override
  _CreateListModalState createState() => _CreateListModalState();
}

class _CreateListModalState extends State<CreateListModal> {
  final name = TextEditingController();
  final description = TextEditingController();

  // Destroy text controllers on dipose
  @override
  void dispose() {
    super.dispose();
    name.dispose();
    description.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: EdgeInsets.only(left: 8, right: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Create List",
                  style: h2,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Name",
                        style: h3,
                      ),
                      TextField(
                        controller: name,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Description",
                        style: h3,
                      ),
                      TextField(
                        controller: description,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text("Create"),
                    onPressed: () async {
                      var newListMeta = await ListsCollection.createList(
                          name.text, description.text, context);

                      if (newListMeta != null) {
                        Navigator.pop(context);
                        var token = Provider.of<AppUser>(context).token;
                        Provider.of<ActiveList>(context).loadList(newListMeta, token);
                      }
                      // TODO: Show error message otherwise
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
