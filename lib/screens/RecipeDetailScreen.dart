import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_project/models/Ingredients.dart';
import 'package:recipes_project/models/RecipeStep.dart';
import 'package:recipes_project/widgets/BodyRecipeDetailsWidget.dart';
import 'package:recipes_project/widgets/IngredientsWidget.dart';
import 'package:recipes_project/widgets/StepWidget.dart';
import 'package:recipes_project/widgets/TextWidgets.dart';

import '../models/Recipe.dart';
import '../utils/Categories.dart';
import '../widgets/HeaderRecipeWidget.dart';

class RecipeDetailScreen extends StatelessWidget{
  final Recipe recipe;

  RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    var category = getCategoryType(recipe.categoryCode);
    var ingredients = [
      Ingredients(name: "Cebolla", count: 1, idRecipe: 1, unit: "Und"),
      Ingredients(name: "Tomate", count: 1, idRecipe: 1, unit: "Und"),
      Ingredients(name: "Ajo", count: 1, idRecipe: 1, unit: "Und"),
      Ingredients(name: "Pasta de su preferencia", count: 500, idRecipe: 1, unit: "g"),
    ];

    var steps = [
      RecipeStep(idRecipe: 1, description: 'Hervir agua en una olla y agregar la pasta y sal ', order: 1),
      RecipeStep(idRecipe: 1, description: 'Picar finamente la cebolla, tomate, ajo y sofreir en un sartén con un chorro de aceite', order: 1),
    ];
   return Scaffold(
     body: SafeArea(
       child: Column(
         children: [
           HeaderRecipeWidget(categoryType: category,showOptions: true, imagePath: recipe.imagePath,),
           BodyRecipeDetailsWidget(recipe: recipe, ingredients: ingredients, steps: steps)],
       )
     )
   );
  }
}