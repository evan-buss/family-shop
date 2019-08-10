import 'package:http/http.dart' as http;
import 'package:family_list/util/urls.dart';
import 'dart:convert';

class ListsMetadata {
  int listID;
  String title;
  String description;

  ListsMetadata({this.listID, this.title, this.description});

  factory ListsMetadata.fromJson(Map<String, dynamic> json) {
    return ListsMetadata(
        listID: json['listID'],
        title: json['title'],
        description: json['description']);
  }
}

class UserLists {
  // Retrieve the lists associated with the logged in user.
  static Future<List<ListsMetadata>> getLists(String token) async {
    final response = await http.get(getListsURL,
        headers: {"Authorization": "Bearer $token"}).timeout(const Duration(seconds: 3));
    print("list token: " + token);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);
      Iterable i = json.decode(response.body);
      List<ListsMetadata> lists =
          i.map((i) => ListsMetadata.fromJson(i)).toList();
      return lists;
    }
    throw Exception("unable to load lists");
  }
}
