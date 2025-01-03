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

  static Tag fromMap(Map<String, dynamic> map){
    return Tag(
        id: map['id'],
        description: map['description']
    );
  }

  Tag copyWith({int? id, String? description}){
    return Tag(description: description?? this.description, id: id ?? this.id);
  }

}