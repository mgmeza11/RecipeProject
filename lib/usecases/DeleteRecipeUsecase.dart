import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/usecases/DeleteStepsByRecipeUsecase.dart';

import '../repository/RecipeRepository.dart';
import 'DeleteIngredientsByRecipeUsecase.dart';
import 'DeleteTagsByRecipeUsecase.dart';

class DeleteRecipeUsecase {

  RecipeRepository recipeRepository;
  DeleteStepsByRecipeUsecase deleteStepsByRecipeUsecase;
  DeleteTagsByRecipeUsecase deleteTagsByRecipeUsecase;
  DeleteIngredientsByRecipeUsecase deleteIngredientsUsecase;

  DeleteRecipeUsecase({required this.recipeRepository, required this.deleteStepsByRecipeUsecase, required this.deleteTagsByRecipeUsecase, required this.deleteIngredientsUsecase});

  Future<void> call(int idRecipe) async {
    await deleteStepsByRecipeUsecase.call(idRecipe);
    await deleteTagsByRecipeUsecase.call(idRecipe);
    await deleteIngredientsUsecase.call(idRecipe);
    await recipeRepository.deleteRecipe(idRecipe);
  }
}

final deleteRecipeUsecaseProvider = Provider<DeleteRecipeUsecase>((ref) {
  final recipeRepository = ref.read(recipeRepositoryProvider);
  final deleteStepsByRecipeUsecase = ref.read(deleteStepsByRecipeUsecaseProvider);
  final deleteTagsByRecipeUsecase = ref.read(deleteTagsByRecipeUsecaseProvider);
  final deleteIngredientsUsecase = ref.read(deleteIngredientsByRecipeUsecaseProvider);
  return DeleteRecipeUsecase(recipeRepository: recipeRepository, deleteStepsByRecipeUsecase: deleteStepsByRecipeUsecase, deleteTagsByRecipeUsecase:  deleteTagsByRecipeUsecase, deleteIngredientsUsecase: deleteIngredientsUsecase);
});