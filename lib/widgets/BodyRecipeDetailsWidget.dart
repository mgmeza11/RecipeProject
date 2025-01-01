import 'package:flutter/cupertino.dart';
import 'package:recipes_project/models/Recipe.dart';
import 'package:recipes_project/models/RecipeStep.dart';

import 'IngredientsWidget.dart';
import 'StepWidget.dart';
import 'TextWidgets.dart';

class BodyRecipeDetailsWidget extends StatelessWidget {

  final Recipe recipe;
  final ingredients;
  final steps;

  BodyRecipeDetailsWidget({super.key, required this.recipe, required this.ingredients, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LargeTitle(text: recipe.name),
            const SizedBox(height: 5,),
            if(recipe.description != null )DetailText(text: recipe.description!,),
            const SizedBox(height: 10,),
            const MediumTitle(text: "Ingredientes"),
            for(var ingredient in ingredients) IngredientWidget(ingredient: ingredient),
            const SizedBox(height: 10,),
            const MediumTitle(text: "Pasos"),
            for(var step in steps) StepWidget(step: step),
          ]
      ),);
  }
}