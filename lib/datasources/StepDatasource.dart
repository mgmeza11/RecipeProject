import 'package:recipes_project/models/Step.dart';
import 'package:recipes_project/utils/DatabaseUtils.dart';

import '../services/DatabaseHelper.dart';

class StepDatasource {
  final DatabaseHelper databaseHelper;

  StepDatasource(this.databaseHelper);

  Future<void> insert(Step tag) async {
    await databaseHelper.add(STEPS_TABLENAME, tag.toMap());
  }

  Future<List<Step>> getByRecipe(int recipeId) async {
    final data = await databaseHelper.getWhere(STEPS_TABLENAME, 'id_recipe = ? ', [recipeId]);
    return data.map((item) => Step.fromMap(item)).toList();
  }

  Future<void> delete (Step ingredients) async {
    await databaseHelper.delete(STEPS_TABLENAME, ingredients.id!!);
  }

  Future<void> deleteByRecipe(int recipeId) async {
    await databaseHelper.deleteWhere(STEPS_TABLENAME, 'id_recipe = ? ', [recipeId]);
  }

}