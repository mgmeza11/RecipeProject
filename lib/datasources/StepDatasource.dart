import 'package:recipes_project/models/RecipeStep.dart';
import 'package:recipes_project/utils/DatabaseUtils.dart';

import '../services/DatabaseHelper.dart';

class StepDatasource {
  final DatabaseHelper databaseHelper;

  StepDatasource(this.databaseHelper);

  Future<void> insert(RecipeStep tag) async {
    await databaseHelper.add(STEPS_TABLENAME, tag.toMap());
  }

  Future<List<RecipeStep>> getByRecipe(int recipeId) async {
    final data = await databaseHelper.getWhere(STEPS_TABLENAME, 'id_recipe = ? ', [recipeId]);
    return data.map((item) => RecipeStep.fromMap(item)).toList();
  }

  Future<void> delete (RecipeStep ingredients) async {
    await databaseHelper.delete(STEPS_TABLENAME, ingredients.id!!);
  }

  Future<void> deleteByRecipe(int recipeId) async {
    await databaseHelper.deleteWhere(STEPS_TABLENAME, 'id_recipe = ? ', [recipeId]);
  }

}