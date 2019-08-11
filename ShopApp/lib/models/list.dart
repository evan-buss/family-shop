import 'package:family_list/models/app_user.dart';
import 'package:family_list/util/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ItemList with ChangeNotifier 
{
  int listID;
  String name;
  // Contains all items in the list
  List<ListItem> list ; 


  // factory ItemList.getList(int listID) {
  //   return 
  // }
  // void test () {
  //   Provider.
  // }
  // void _getItems(int listID) async {
  //   // TODO: Figure out how to retrieve token
  //   var response = await http.get(getListsURL + "1", headers: {
  //     "authorization": "Bearer $token";
  //   });
  // }
}

class ListItem {
  final int itemID;
  final String title;
  final String description;

  ListItem({this.itemID, this.title, this.description});

  factory ListItem.fromJson(Map<String, dynamic> json) {
    return ListItem(
        itemID: json['itemID'],
        title: json['title'],
        description: json['description']);
  }

  Map<String, String> toJson() => {'title': title, 'description': description};
}
