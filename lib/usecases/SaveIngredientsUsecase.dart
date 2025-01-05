import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/models/Ingredients.dart';

import '../repository/IngredientsRepository.dart';

class SaveIngredientsUsecase {

  IngredientsRepository ingredientsRepository;

  SaveIngredientsUsecase({required this.ingredientsRepository});

  Future<void> call(List<Ingredients> currentIngredients, int idRecipe) async {
    if (currentIngredients.isNotEmpty) {
      List<Ingredients> newIngredients = currentIngredients.map((e) => e.copyWith(idRecipe: idRecipe)).toList();
      await ingredientsRepository.addList(newIngredients);
    }
}
}

final saveIngredientsUsecaseProvider = Provider<SaveIngredientsUsecase>((ref) {
  final ingredientsRepository = ref.read(ingredientsRepositoryProvider);
  return SaveIngredientsUsecase(ingredientsRepository: ingredientsRepository);
});