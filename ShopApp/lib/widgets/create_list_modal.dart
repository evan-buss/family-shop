import 'package:family_list/models/list_meta.dart';
import 'package:family_list/util/text_styles.dart';
import 'package:flutter/material.dart';

class CreateListModal extends StatefulWidget {
  @override
  _CreateListModalState createState() => _CreateListModalState();
}

class _CreateListModalState extends State<CreateListModal> {
  final name = TextEditingController();
  final description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.only(top: 128, bottom: 128, left: 64, right: 64),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Create List",
              style: h2,
            ),
            Text(
              "Name",
              style: h3,
            ),
            TextField(
              controller: name,
            ),
            Text(
              "Description",
              style: h3,
            ),
            TextField(
              controller: description,
            ),
            RaisedButton(
              child: Text("Create"),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () async {
                var status = await ListsCollection.createList(
                    name.text, description.text, context);
                if (status == 200) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
