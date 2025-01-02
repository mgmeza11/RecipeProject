
import 'package:recipes_project/models/Ingredients.dart';

import 'Recipe.dart';
import 'RecipeStep.dart';

class RecipeState {
  Recipe? recipe;
  List<Ingredients> ingredients = [];
  List<RecipeStep> steps = [];

  RecipeState(this.recipe, this.ingredients, this.steps);

  RecipeState cloneWithIngredients(List<Ingredients> ingredients){
    return RecipeState(recipe, ingredients, steps);
  }

  RecipeState cloneWithSteps(List<RecipeStep> steps){
    return RecipeState(recipe, ingredients, steps);
  }

  RecipeState cloneWithRecipe(Recipe recipe){
    return RecipeState(recipe, ingredients, steps);
  }
}