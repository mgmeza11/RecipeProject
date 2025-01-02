import 'Ingredients.dart';
import 'RecipeStep.dart';

class Recipe{
  int? id;
  String name;
  String? description;
  String? imagePath;
  String categoryCode;
  List<Ingredients> ingredients;
  List<RecipeStep> steps;

  Recipe({
    this.id,
    required this.name,
    this.description,
    this.imagePath,
    required this.categoryCode,
    required this.ingredients,
    required this.steps
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
        categoryCode: map['category_code'],
        ingredients: [],
        steps: []
    );
  }

  Recipe copyWith({int? id, String? name, String? description, String? imagePath, String? categoryCode, List<Ingredients>? ingredients, List<RecipeStep>? steps}){
    return Recipe(id: id?? this.id, name: name?? this.name, description: description?? this.description, imagePath: imagePath?? this.imagePath,
        categoryCode: categoryCode?? this.categoryCode, ingredients: ingredients?? this.ingredients, steps: steps?? this.steps);
}
}