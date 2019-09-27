import 'dart:convert';
import 'dart:typed_data';

class ListItem {
  int id;
  String name;
  String description;
  Uint8List image;

  ListItem({this.id, this.name, this.description, this.image});

  /// Convert a json object to a ListItem.
  ///
  /// Used for converting API responses to Dart objects.
  factory ListItem.fromJson(Map<String, dynamic> json) {
    return ListItem(
        id: json['id'],
        name: json['name'],
        description: json['description'],
//        image: Uint8List(10));
        image: base64.decode(json['image']));
  }

  /// Covert a ListItem to JSON.
  ///
  /// Used for API new item creation.
  Map<String, String> toJson(int listID) => {
        'id': listID.toString(),
        'name': name,
        'description': description,
        'image': base64.encode(image)
      };

  /// Covert a ListItem to JSON.
  ///
  /// Used for API new item creation.
  Map<String, String> toJsonPut(int listID) => {
        'itemID': id.toString(),
        'listID': listID.toString(),
        'title': name,
        'description': description,
        'image': base64.encode(image)
      };
}
