import 'package:http/http.dart' as http;
import 'package:family_list/util/urls.dart';
import 'package:family_list/util/local_storage.dart';
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
  static Future<List<ListsMetadata>> getLists() async {
    final response = await http.get(getListsURL, headers: {
      "Authorization": await getAuthToken()
    }).timeout(const Duration(seconds: 3));
    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      Iterable i = json.decode(response.body);
      List<ListsMetadata> lists =
          i.map((i) => ListsMetadata.fromJson(i)).toList();
      return lists;
    }
    throw Exception("unable to load lists");
  }
}
