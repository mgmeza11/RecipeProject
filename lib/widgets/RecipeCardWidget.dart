import 'package:flutter/material.dart';
import 'package:recipes_project/models/Recipe.dart';
import 'package:recipes_project/widgets/HeaderRecipeWidget.dart';
import 'package:recipes_project/widgets/TextWidgets.dart';

class RecipeCardWidget extends StatelessWidget{
  final Recipe recipe;
  const RecipeCardWidget({super.key, required this.recipe});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderRecipeWidget(categoryCode: recipe.categoryCode, imagePath: recipe.imagePath, height: 100),
          Text(recipe.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start, maxLines: 1, overflow: TextOverflow.ellipsis,),
          DetailText(text: recipe.description ?? "", maxLines: 2),
        ],
      )
    )
    ;
  }
  
}