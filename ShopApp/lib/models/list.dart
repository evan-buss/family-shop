import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';

import 'package:family_list/models/list_meta.dart';
import 'package:family_list/util/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ActiveList with ChangeNotifier {
  ListMetadata _metaData;
  List<ListItem> items;
  bool isLoading = false;
  String _token;

  ActiveList();

  get metaData => _metaData;

  // FIXME: Not sure if I like having to sepearate load methods. Not sure how to fix it.
  /// Load a given list given its metadata and an auth token
  void loadList(ListMetadata meta, String token) async {
    print("loading list from api");
    _metaData = meta;
    _token = token;
    var response = await http.get(itemsURL + _metaData.listID.toString(),
        headers: {"authorization": "Bearer $token"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonBody = json.decode(response.body);
      items = jsonBody["items"]
          .map<ListItem>((json) => new ListItem.fromJson(json))
          .toList();
      notifyListeners();
    }
  }

  // Reload the list. The list must be loaded using loadList before calling reload.
  void reloadList() async {
    if (_token != null) {
      var response = await http.get(itemsURL + _metaData.listID.toString(),
          headers: {"authorization": "Bearer $_token"});
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonBody = json.decode(response.body);
        items = jsonBody["items"]
            .map<ListItem>((json) => new ListItem.fromJson(json))
            .toList();
        notifyListeners();
      }
    }
  }

  /// Create a new item in the currently selected list
  void addItem(String title, String description, Uint8List imageBytes,
      String token) async {
    var item =
        new ListItem(description: title, title: description, image: imageBytes);
    final response = await http.post(itemsURL,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: json.encode(item.toJson(_metaData.listID)));
    if (response.statusCode == 201) {
      items.add(ListItem.fromJson(json.decode(response.body)));
      notifyListeners();
    }
  }

  /// Delete a specific item from the list
  void deleteItem(ListItem item) async {
    final response = await http.delete(
      itemsURL + item.itemID.toString(),
      headers: {"Authorization": "Bearer $_token"},
    );
    print(response.statusCode);
    // 204 = No Content
    if (response.statusCode == 204) {
      items.remove(item);
      notifyListeners();
    }
  }
}

class ListItem {
  final int itemID;
  final String title;
  final String description;
  final Uint8List image;

  ListItem({this.itemID, this.title, this.description, this.image});

  /// Convert a json object to a ListItem.
  ///
  /// Used for converting API responses to Dart objects.
  factory ListItem.fromJson(Map<String, dynamic> json) {
    return ListItem(
        itemID: json['itemID'],
        title: json['title'],
        description: json['description'],
        image: base64.decode(json['image']));
  }

  /// Covert a ListItem to JSON.
  ///
  /// Used for converting object to API request.
  Map<String, String> toJson(int listID) => {
        'listID': listID.toString(),
        'title': title,
        'description': description,
        'image': base64.encode(image)
      };
}
