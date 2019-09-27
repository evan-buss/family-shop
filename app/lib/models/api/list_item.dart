import 'dart:convert';
import 'dart:typed_data';

class Creator {
  int id;
  String username;
  String email;

  Creator({this.id, this.username, this.email});

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
        id: json['id'], username: json['username'], email: json['email']);
  }
}

class ListItem {
  int id;
  String name;
  String description;
  DateTime creation;
  Creator creator;
  Uint8List image;

  ListItem(
      {this.id,
      this.name,
      this.description,
      this.creator,
      this.creation,
      this.image});

  /// Convert a json object to a ListItem.
  ///
  /// Used for converting API responses to Dart objects.
  factory ListItem.fromJson(Map<String, dynamic> json) {
    return ListItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      creator: Creator.fromJson(json['creator']),
      creation: DateTime.parse(json['creation']).toLocal(),
      image: json['image'] != null ? base64.decode(json['image']) : null,
    );
  }

  /// Covert a ListItem to JSON.
  ///
  /// Used for API new item creation.
  Map<String, String> toJson(int listID) => {
        'listID': listID.toString(),
        'name': name,
        'description': description,
        'image': image != null ? base64.encode(image) : null
      };

  /// Covert a ListItem to JSON.
  ///
  /// Used for API item updates
  Map<String, String> toJsonPut(int listID) => {
        'itemID': id.toString(),
        'listID': listID.toString(),
        'name': name,
        'description': description,
        'image': image != null ? base64.encode(image) : null
      };
}
