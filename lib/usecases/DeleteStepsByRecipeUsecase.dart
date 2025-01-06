import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/repository/RecipeStepRepository.dart';

class DeleteStepsByRecipeUsecase {

  RecipeStepRepository recipeStepRepository;

  DeleteStepsByRecipeUsecase({required this.recipeStepRepository});

  Future<void> call(int idRecipe) async {
    await recipeStepRepository.deleteByRecipe(idRecipe);
  }
}

final deleteStepsByRecipeUsecaseProvider = Provider<DeleteStepsByRecipeUsecase>((ref) {
  final recipeRepository = ref.read(recipeStepRepositoryProvider);
  return DeleteStepsByRecipeUsecase(recipeStepRepository: recipeRepository);
});