import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/IngredientsRepository.dart';

class DeleteIngredientsByRecipeUsecase {

  IngredientsRepository ingredientsRepository;

  DeleteIngredientsByRecipeUsecase({required this.ingredientsRepository});

  Future<void> call(int idRecipe) async {
    await ingredientsRepository.deleteByRecipe(idRecipe);
  }
}

final deleteIngredientsByRecipeUsecaseProvider = Provider<DeleteIngredientsByRecipeUsecase>((ref) {
  final ingredientsRepository = ref.read(ingredientsRepositoryProvider);
  return DeleteIngredientsByRecipeUsecase(ingredientsRepository: ingredientsRepository);
});