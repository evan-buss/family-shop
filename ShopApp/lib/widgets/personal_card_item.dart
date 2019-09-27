import 'package:family_list/models/api/list_item.dart';
import 'package:family_list/models/state/active_list.dart';
import 'package:family_list/screens/create_item_screen.dart';
import 'package:family_list/util/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class PersonalCardItem extends StatelessWidget {
  final ListItem item;
  final Function callback;

  PersonalCardItem(this.item, this.callback);

  String getFormattedDate(DateTime date) {
    DateFormat formatter = DateFormat("MMM d");
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Dismissible(
        key: ObjectKey(item),
        background: Container(
          color: Theme.of(context).errorColor,
        ),
        onDismissed: (direction) {
          callback();
        },
        child: ListTile(
          onTap: () {
            // Edit the item on click
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateItemScreen(listItem: item),
              ),
            );
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                item.name,
                style: h3,
              ),
              Tooltip(
                message: item.creation.toString(),
                child: Text(
                  getFormattedDate(item.creation),
                  style: h3,
                ),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(item.description),
              Text(item.creator.username.split(" ")[0]),
            ],
          ),
          leading: item.image != null
              ? ClipRRect(
                  child: Image.memory(item.image),
                  borderRadius: BorderRadius.circular(4),
                )
              : Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.local_grocery_store,
                    size: 40,
                  ),
                ),
        ),
      ),
    );
  }
}
