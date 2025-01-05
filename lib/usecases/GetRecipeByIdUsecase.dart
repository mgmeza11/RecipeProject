import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/usecases/GetStepsByRecipeUsecase.dart';

import '../models/Ingredients.dart';
import '../models/Recipe.dart';
import '../models/RecipeStep.dart';
import '../models/Tag.dart';
import '../repository/RecipeRepository.dart';
import 'GetIngredientsByRecipeUsecase.dart';
import 'GetTagsByRecipeUsecase.dart';

class GetRecipeByIdUsecase {
  RecipeRepository recipeRepository;
  GetStepsByRecipeUsecase getStepsByRecipeUsecase;
  GetTagsByRecipeUsecase getTagsByRecipeUsecase;
  GetIngredientsByRecipeUsecase getIngredientsByRecipeUsecase;

  GetRecipeByIdUsecase(
      {required this.recipeRepository,
      required this.getStepsByRecipeUsecase,
      required this.getTagsByRecipeUsecase,
      required this.getIngredientsByRecipeUsecase});

  Future<Recipe?> call(int idRecipe) async {
    Recipe? recipe = await recipeRepository.findById(idRecipe);
    if(recipe != null){
      List<RecipeStep> stepList = await getStepsByRecipeUsecase.call(idRecipe);
      List<Ingredients> ingredientList = await getIngredientsByRecipeUsecase.call(idRecipe);
      List<Tag> tagList = await getTagsByRecipeUsecase.call(idRecipe);
      return recipe.copyWith(steps: stepList, ingredients: ingredientList, tags: tagList);
    }
    return null;
  }
}

final getRecipeByIdUsecaseProvider = Provider<GetRecipeByIdUsecase>((ref) {
  final recipeRepository = ref.read(recipeRepositoryProvider);
  final getStepsByRecipeUsecase = ref.read(getStepsByRecipeUsecaseProvider);
  final getTagsByRecipeUsecase = ref.read(getTagsByRecipeUsecaseProvider);
  final getIngredientsByRecipeUsecase = ref.read(getIngredientsByRecipeUsecaseProvider);
  return GetRecipeByIdUsecase(recipeRepository: recipeRepository, getIngredientsByRecipeUsecase: getIngredientsByRecipeUsecase, getStepsByRecipeUsecase: getStepsByRecipeUsecase, getTagsByRecipeUsecase: getTagsByRecipeUsecase);
});
