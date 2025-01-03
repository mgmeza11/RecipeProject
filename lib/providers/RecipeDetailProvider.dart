import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Ingredients.dart';
import '../models/Recipe.dart';
import '../models/RecipeStep.dart';
import '../models/Tag.dart';
import '../repository/IngredientsRepository.dart';
import '../repository/RecipeRepository.dart';
import '../repository/RecipeStepRepository.dart';
import '../repository/TagRepository.dart';
import '../utils/CustomException.dart';

class RecipeDetailNotifier extends StateNotifier<AsyncValue<Recipe>>{
  RecipeRepository recipeRepository;
  RecipeStepRepository stepRepository;
  IngredientsRepository ingredientsRepository;
  TagRepository tagRepository;

  RecipeDetailNotifier({required this.recipeRepository, required this.stepRepository, required this.ingredientsRepository, required this.tagRepository }): super(const AsyncValue.loading());

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
      List<Tag> tagList = await tagRepository.getByRecipe(idRecipe);
      state = AsyncValue.data(recipe.copyWith(ingredients: ingredientList, steps: stepList, tags: tagList));
    } catch (e) {
      state = AsyncValue.error(CustomException(CustomExceptionTypes.technicalError.message), StackTrace.empty);
    }

  }

  void deleteRecipe(int idRecipe){

  }


}

final recipeDetailProvider = StateNotifierProvider<RecipeDetailNotifier, AsyncValue<Recipe>>((ref) {
  final recipeRpository = ref.read(recipeRepositoryProvider);
  final stepRepository = ref.read(recipeStepRepositoryProvider);
  final ingredientsRepository = ref.read(ingredientsRepositoryProvider);
  final tagRepository = ref.read(tagRepositoryProvider);
  return RecipeDetailNotifier(recipeRepository: recipeRpository, stepRepository: stepRepository, ingredientsRepository: ingredientsRepository, tagRepository: tagRepository);
});