import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/models/Ingredients.dart';
import 'package:recipes_project/models/RecipeStep.dart';
import 'package:recipes_project/providers/RecipeDetailProvider.dart';

import '../models/Recipe.dart';
import '../utils/Categories.dart';
import '../widgets/ErrorWidget.dart';
import '../widgets/HeaderRecipeWidget.dart';
import '../widgets/IngredientsWidget.dart';
import '../widgets/LoadingWidget.dart';
import '../widgets/StepWidget.dart';
import '../widgets/TextWidgets.dart';


class RecipeDetailScreen extends ConsumerStatefulWidget {
  int idRecipe;

  RecipeDetailScreen({super.key, required this.idRecipe});

  @override
  ConsumerState<RecipeDetailScreen> createState() => RecipeDetailScreenState();
}

class RecipeDetailScreenState extends ConsumerState<RecipeDetailScreen>{
  @override
  void initState() {
    super.initState();
    ref.read(recipeDetailProvider.notifier).init(widget.idRecipe);
  }
  @override
  Widget build(BuildContext context) {
    var recipeStateProvider = ref.watch(recipeDetailProvider);
   return Scaffold(
     appBar: AppBar(),
     body: SafeArea(
       child: recipeStateProvider.when(
           data: (recipe){
             return Column(
               children: [
                 HeaderRecipeWidget(categoryCode: recipe.categoryCode,showOptions: true, imagePath: recipe.imagePath,),
                 BodyRecipeDetailsWidget(recipe: recipe, ingredients: recipe.ingredients, steps: recipe.steps)],
             );
           }, error: (e, s) {
         return CustomErrorWidget(message: e.toString());
       }, loading: () {
         return LoadingWidget();
       })

     )
   );
  }

  Widget BodyRecipeDetailsWidget({required Recipe recipe, required List<Ingredients> ingredients, required List<RecipeStep> steps}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LargeTitle(text: recipe.name),
            const SizedBox(height: 5,),
            if(recipe.description != null ) DetailText(text: recipe.description!,),
            const SizedBox(height: 10,),
            const MediumTitle(text: "Ingredientes"),
            if( ingredients.isNotEmpty) IngredientTitle(),
            for(var ingredient in ingredients) IngredientWidget(ingredient),
            const SizedBox(height: 10,),
            const MediumTitle(text: "Pasos"),
            for(var step in steps) StepWidget(step: step),
          ]
      ),);
  }
}