import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Ingredients.dart';
import '../models/Recipe.dart';
import '../models/RecipeStep.dart';
import '../repository/IngredientsRepository.dart';
import '../repository/RecipeRepository.dart';
import '../repository/RecipeStepRepository.dart';
import '../utils/CustomException.dart';

class RecipeDetailNotifier extends StateNotifier<AsyncValue<Recipe>>{
  RecipeRepository recipeRepository;
  RecipeStepRepository stepRepository;
  IngredientsRepository ingredientsRepository;

  RecipeDetailNotifier({required this.recipeRepository, required this.stepRepository, required this.ingredientsRepository }): super(const AsyncValue.loading());

  void init(int idRecipe) async {
      Recipe? recipe = await recipeRepository.findById(idRecipe);
      if(recipe != null){
        getRecipeData(recipe);
      }else{
        state = AsyncValue.error(CustomException(CustomExceptionTypes.notFound.message), StackTrace.empty);
      }

  }

  void getRecipeData(Recipe recipe) async {
    int idRecipe = recipe.id!;
    try{
      List<RecipeStep> stepList = await stepRepository.getByRecipe(idRecipe);
      List<Ingredients> ingredientList = await ingredientsRepository.getByRecipe(idRecipe);
      state = AsyncValue.data(recipe.copyWith(ingredients: ingredientList, steps: stepList));
    } catch (e) {
      state = AsyncValue.error(CustomException(CustomExceptionTypes.technicalError.message), StackTrace.empty);
    }

  }
}

final recipeDetailProvider = StateNotifierProvider<RecipeDetailNotifier, AsyncValue<Recipe>>((ref) {
  final recipeRpository = ref.read(recipeRepositoryProvider);
  final stepRepository = ref.read(recipeStepRepositoryProvider);
  final ingredientsRepository = ref.read(ingredientsRepositoryProvider);
  return RecipeDetailNotifier(recipeRepository: recipeRpository, stepRepository: stepRepository, ingredientsRepository: ingredientsRepository);
});