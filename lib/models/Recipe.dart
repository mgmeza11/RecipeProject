class Recipe{
  int? id;
  String name;
  String? description;
  String? imagePath;
  String categoryCode;

  Recipe({
    this.id,
    required this.name,
    this.description,
    this.imagePath,
    required this.categoryCode
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'description' : description,
      'image_path': imagePath,
      'category_code' : categoryCode
    };
  }

  static Recipe fromMap(Map<String, dynamic> map){
    return Recipe(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        imagePath: map['image_path'],
        categoryCode: map['category_code']
    );
  }
}