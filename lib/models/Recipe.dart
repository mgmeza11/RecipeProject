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
      'imagePath': imagePath,
      'categoryCode' : categoryCode
    };
  }
}