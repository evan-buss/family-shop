class ListMetadata {
  int listID;
  String title;
  String description;

  ListMetadata({this.listID, this.title, this.description});

  factory ListMetadata.fromJson(Map<String, dynamic> json) {
    return ListMetadata(
        listID: json['id'],
        title: json['title'],
        description: json['description']);
  }
}