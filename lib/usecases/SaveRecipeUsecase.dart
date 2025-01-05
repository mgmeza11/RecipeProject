import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/repository/RecipeRepository.dart';
import 'package:recipes_project/usecases/SaveIngredientsUsecase.dart';
import 'package:recipes_project/usecases/SaveRecipeTagUsecase.dart';
import 'package:recipes_project/usecases/SaveStepsUsecase.dart';

import '../models/Recipe.dart';

class SaveRecipeUsecase {

  RecipeRepository recipeRepository;
  SaveIngredientsUsecase saveIngredientsUsecase;
  SaveStepsUsecase saveStepsUsecase;
  SaveRecipeTagUsecase saveRecipeTagUsecase;

  SaveRecipeUsecase({required this.recipeRepository, required this.saveIngredientsUsecase, required this.saveStepsUsecase, required this.saveRecipeTagUsecase });

  Future<void> call (Recipe recipe ) async{
    int idRecipe = await recipeRepository.insert(recipe);
    await saveStepsUsecase.call(recipe.steps, idRecipe);
    await saveIngredientsUsecase(recipe.ingredients, idRecipe);
    await saveRecipeTagUsecase(recipe.tags, idRecipe);
  }

}

final saveRecipeUsecaseProvider = Provider<SaveRecipeUsecase>((ref) {
  final recipeRepository = ref.read(recipeRepositoryProvider);
  final saveIngredientsUsecase = ref.read(saveIngredientsUsecaseProvider);
  final saveStepsUsecase = ref.read (saveStepsUsecaseProvider);
  final saveRecipeTagUsecase = ref.read (saveRecipeTagUsecaseProvider);
  return SaveRecipeUsecase(recipeRepository: recipeRepository, saveIngredientsUsecase: saveIngredientsUsecase, saveStepsUsecase: saveStepsUsecase, saveRecipeTagUsecase: saveRecipeTagUsecase);
});