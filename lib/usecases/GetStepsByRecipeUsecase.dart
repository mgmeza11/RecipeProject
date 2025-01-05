import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/models/RecipeStep.dart';

import '../repository/RecipeStepRepository.dart';

class GetStepsByRecipeUsecase {

  RecipeStepRepository recipeStepRepository;

  GetStepsByRecipeUsecase({required this.recipeStepRepository});

  Future<List<RecipeStep>> call(int idRecipe) async {
    return recipeStepRepository.getByRecipe(idRecipe);
  }
}

final getStepsByRecipeUsecaseProvider = Provider<GetStepsByRecipeUsecase>((ref) {
  final recipeRepository = ref.read(recipeStepRepositoryProvider);
  return GetStepsByRecipeUsecase(recipeStepRepository: recipeRepository);
});