class ListItem {
  final int itemID;
  final String title;
  final String description;

  ListItem({this.itemID, this.title, this.description});

  factory ListItem.fromJson(Map<String, dynamic> json) {
    return ListItem(
        itemID: json['itemID'],
        title: json['title'],
        description: json['description']);
  }

  Map<String, String> toJson() => {'title': title, 'description': description};
}
