import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Ingredients.dart';
import '../repository/IngredientsRepository.dart';

class GetIngredientsByRecipeUsecase {

  IngredientsRepository ingredientsRepository;

  GetIngredientsByRecipeUsecase({required this.ingredientsRepository});

  Future<List<Ingredients>> call(int idRecipe) async {
    return ingredientsRepository.getByRecipe(idRecipe);
  }
}

final getIngredientsByRecipeUsecaseProvider = Provider<GetIngredientsByRecipeUsecase>((ref) {
  final recipeRepository = ref.read(ingredientsRepositoryProvider);
  return GetIngredientsByRecipeUsecase(ingredientsRepository: recipeRepository);
});