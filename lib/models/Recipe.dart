import 'package:recipes_project/models/Tag.dart';

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
  List<Tag> tags;

  Recipe({
    this.id,
    required this.name,
    this.description,
    this.imagePath,
    required this.categoryCode,
    required this.ingredients,
    required this.steps,
    required this.tags
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
        steps: [],
        tags: []
    );
  }

  Recipe copyWith({int? id, String? name, String? description, String? imagePath, String? categoryCode, List<Ingredients>? ingredients, List<RecipeStep>? steps, List<Tag>? tags}){
    return Recipe(id: id?? this.id, name: name?? this.name, description: description?? this.description, imagePath: imagePath?? this.imagePath,
        categoryCode: categoryCode?? this.categoryCode, ingredients: ingredients?? this.ingredients, steps: steps?? this.steps, tags: tags ?? this.tags );
}
}