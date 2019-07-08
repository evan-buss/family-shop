class ListItem {
  final int itemID;
  final int userID;
  final String title;
  final String description;

  ListItem({this.itemID, this.userID, this.title, this.description});

  factory ListItem.fromJson(Map<String, dynamic> json) {
    return ListItem(
        itemID: json['itemID'],
        userID: json['userID'],
        title: json['title'],
        description: json['description']);
  }

  Map<String, dynamic> toJson() =>
      {'userID': userID, 'title': title, 'description': description};
}
