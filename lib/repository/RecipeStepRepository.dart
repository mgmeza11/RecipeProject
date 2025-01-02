import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/datasources/StepDatasource.dart';

import '../models/RecipeStep.dart';

class RecipeStepRepository{

  final StepDatasource stepDatasource;

  RecipeStepRepository(this.stepDatasource);

  Future<List<RecipeStep>> getByRecipe(int idRecipe) async{
    return stepDatasource.getByRecipe(idRecipe);
  }

  Future<void> addList(List<RecipeStep> recipeStepList) async {
    await stepDatasource.addList(recipeStepList);
  }

}

final recipeStepRepositoryProvider = Provider<RecipeStepRepository>((ref) {
  final stepDatasource = ref.read(stepDatasourceProvider);
  return RecipeStepRepository(stepDatasource);
});