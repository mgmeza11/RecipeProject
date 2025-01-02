import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_project/models/Recipe.dart';
import 'package:recipes_project/utils/Categories.dart';
import 'package:recipes_project/widgets/CategoryNameWidget.dart';
import 'package:recipes_project/widgets/HeaderRecipeWidget.dart';
import 'package:recipes_project/widgets/TagWidget.dart';

import '../models/Tag.dart';

class RecipeCardWidget extends StatelessWidget{
  final Recipe recipe;
  RecipeCardWidget({super.key, required this.recipe});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderRecipeWidget(categoryCode: recipe.categoryCode, imagePath: recipe.imagePath,),
          Text(recipe.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
          Text(recipe.description!!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),),
        ],
      )
    )
    ;
  }
  
}