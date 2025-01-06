import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/repository/RecipeRepository.dart';
import 'package:recipes_project/usecases/SaveIngredientsUsecase.dart';
import 'package:recipes_project/usecases/SaveRecipeTagUsecase.dart';
import 'package:recipes_project/usecases/SaveStepsUsecase.dart';

import '../models/Recipe.dart';
import 'DeleteIngredientsByRecipeUsecase.dart';
import 'DeleteStepsByRecipeUsecase.dart';
import 'DeleteTagsByRecipeUsecase.dart';

class SaveRecipeUsecase {
  RecipeRepository recipeRepository;
  SaveIngredientsUsecase saveIngredientsUsecase;
  SaveStepsUsecase saveStepsUsecase;
  SaveRecipeTagUsecase saveRecipeTagUsecase;

  DeleteStepsByRecipeUsecase deleteStepsByRecipeUsecase;
  DeleteTagsByRecipeUsecase deleteTagsByRecipeUsecase;
  DeleteIngredientsByRecipeUsecase deleteIngredientsByRecipeUsecase;

  SaveRecipeUsecase(
      {required this.recipeRepository,
      required this.saveIngredientsUsecase,
      required this.saveStepsUsecase,
      required this.saveRecipeTagUsecase,
      required this.deleteTagsByRecipeUsecase,
      required this.deleteStepsByRecipeUsecase,
      required this.deleteIngredientsByRecipeUsecase});

  Future<void> call(Recipe recipe) async {
    try{
      int idRecipe = await recipeRepository.insert(recipe);
      await deleteStepsByRecipeUsecase.call(idRecipe);
      await saveStepsUsecase.call(recipe.steps, idRecipe);
      await deleteIngredientsByRecipeUsecase.call(idRecipe);
      await saveIngredientsUsecase.call(recipe.ingredients, idRecipe);
      await deleteTagsByRecipeUsecase.call(idRecipe);
      await saveRecipeTagUsecase.call(recipe.tags, idRecipe);
    }catch(e){
      print(e.toString());
    }

  }
}

final saveRecipeUsecaseProvider = Provider<SaveRecipeUsecase>((ref) {
  final recipeRepository = ref.read(recipeRepositoryProvider);
  final saveIngredientsUsecase = ref.read(saveIngredientsUsecaseProvider);
  final saveStepsUsecase = ref.read(saveStepsUsecaseProvider);
  final saveRecipeTagUsecase = ref.read(saveRecipeTagUsecaseProvider);
  final deleteTagsByRecipeUsecase = ref.read(deleteTagsByRecipeUsecaseProvider);
  final deleteStepsByRecipeUsecase =
      ref.read(deleteStepsByRecipeUsecaseProvider);
  final deleteIngredientsByRecipeUsecase =
      ref.read(deleteIngredientsByRecipeUsecaseProvider);

  return SaveRecipeUsecase(
      recipeRepository: recipeRepository,
      saveIngredientsUsecase: saveIngredientsUsecase,
      saveStepsUsecase: saveStepsUsecase,
      saveRecipeTagUsecase: saveRecipeTagUsecase,
      deleteTagsByRecipeUsecase: deleteTagsByRecipeUsecase,
      deleteStepsByRecipeUsecase: deleteStepsByRecipeUsecase,
      deleteIngredientsByRecipeUsecase: deleteIngredientsByRecipeUsecase);
});
