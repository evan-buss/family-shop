import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:family_list/models/api/list_metadata.dart';
import 'package:family_list/util/urls.dart';
import 'package:family_list/models/state/app_user.dart';

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
    try {
      var token = Provider.of<AppUser>(context).token;
      final response = await http.post(listsURL,
          headers: {
            "authorization": "Bearer $token",
            "Content-Type": "application/json"
          },
          body: json.encode({"title": title, "description": description}));
      if (response.statusCode == 200) {
        return ListMetadata.fromJson(json.decode(response.body));
      }
    } catch (ex) {}
    return null;
  }
}
