import 'package:http/http.dart' as http;
import 'package:family_list/util/urls.dart';
import 'package:family_list/util/local_storage.dart';
import 'dart:convert';

class ShoppingList {
  int listID;
  String title;
  String description;

  ShoppingList({this.listID, this.title, this.description});

  factory ShoppingList.fromJson(Map<String, dynamic> json) {
    return ShoppingList(
        listID: json['listID'],
        title: json['title'],
        description: json['description']);
  }
}

class Lists {
  // List<ShoppingList> lists;

  static Future<List<ShoppingList>> getLists() async {
    final response = await http.get(getListsURL, headers: {
      "Authorization": await getAuthToken()
    }).timeout(const Duration(seconds: 3));
    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      Iterable i = json.decode(response.body);
      List<ShoppingList> lists =
          i.map((i) => ShoppingList.fromJson(i)).toList();
      return lists;
    }
    return null;
  }
}
