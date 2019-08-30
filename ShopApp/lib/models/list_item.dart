import 'dart:convert';
import 'dart:typed_data';

class ListItem {
  int itemID;
  String title;
  String description;
  Uint8List image;

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
  /// Used for API new item creation.
  Map<String, String> toJson(int listID) => {
        'listID': listID.toString(),
        'title': title,
        'description': description,
        'image': base64.encode(image)
      };

  /// Covert a ListItem to JSON.
  ///
  /// Used for API new item creation.
  Map<String, String> toJsonPut(int listID) => {
        'itemID': itemID.toString(),
        'listID': listID.toString(),
        'title': title,
        'description': description,
        'image': base64.encode(image)
      };
}
