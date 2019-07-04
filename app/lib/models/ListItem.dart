class ListItem {
  final int id;
  final int userID;
  final String name;
  final String description;

  ListItem({this.id, this.userID, this.name, this.description});

  factory ListItem.fromJson(Map<String, dynamic> json) {
    return ListItem(
        id: json['id'],
        userID: json['user_id'],
        name: json['name'],
        description: json['description']);
  }
}