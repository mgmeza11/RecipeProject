class Tag {
  int? id;
  String description;

  Tag({this.id, required this.description});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'description': description,
    };
  }
}