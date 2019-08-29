import 'package:family_list/models/app_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:family_list/util/urls.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class ListMetadata {
  int listID;
  String title;
  String description;

  ListMetadata({this.listID, this.title, this.description});

  factory ListMetadata.fromJson(Map<String, dynamic> json) {
    return ListMetadata(
        listID: json['listID'],
        title: json['title'],
        description: json['description']);
  }
}

class ListsCollection {
  /// Retrieve the lists associated with the logged in user.
  static Future<List<ListMetadata>> getLists(String token) async {
    final response = await http.get(listsURL, headers: {
      "Authorization": "Bearer $token"
    }).timeout(const Duration(seconds: 3));

    if (response.statusCode == 200) {
      Iterable i = json.decode(response.body);
      List<ListMetadata> lists =
          i.map((i) => ListMetadata.fromJson(i)).toList();
      return lists;
    }
    return null;
  }

  /// Create a new list with title and description
  static Future<ListMetadata> createList(
      String title, String description, BuildContext context) async {
    var token = Provider.of<AppUser>(context).token;
    print(token);
    final response = await http.post(listsURL,
        headers: {
          "authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: json.encode({"title": title, "description": description}));
    if (response.statusCode == 200) {
      return ListMetadata.fromJson(json.decode(response.body));
    }
    return null;
  }
}
