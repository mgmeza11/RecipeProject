import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/RecipeStep.dart';
import '../repository/RecipeStepRepository.dart';

class SaveStepsUsecase {

  RecipeStepRepository recipeStepRepository;

  SaveStepsUsecase({required this.recipeStepRepository});

  Future<void> call(List<RecipeStep> currentSteps, int idRecipe) async {
    if (currentSteps.isNotEmpty) {
      List<RecipeStep> newSteps = currentSteps.asMap().entries.map((e) {
        int index = e.key;
        RecipeStep step = e.value;
        return step.copyWith(order: index, idRecipe: idRecipe);
      }
      ).toList();
      await recipeStepRepository.addList(newSteps);
  }
}
}

final saveStepsUsecaseProvider = Provider<SaveStepsUsecase>((ref) {
  final recipeRepository = ref.read(recipeStepRepositoryProvider);
  return SaveStepsUsecase(recipeStepRepository: recipeRepository);
});