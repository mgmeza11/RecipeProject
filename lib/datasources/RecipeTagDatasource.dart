import 'package:recipes_project/models/RecipeTag.dart';
import 'package:recipes_project/utils/DatabaseUtils.dart';

import '../services/DatabaseHelper.dart';

class RecipeTagDatasource {
  final DatabaseHelper databaseHelper;

  RecipeTagDatasource(this.databaseHelper);

  Future<void> insert(RecipeTag recipeTag) async {
    await databaseHelper.add(TAG_RECIPE_TABLENAME, recipeTag.toMap());
  }

  Future<List<RecipeTag>> getByRecipe(int recipeId) async {
    final data = await databaseHelper.getWhere(TAG_RECIPE_TABLENAME, 'id_recipe = ? ', [recipeId], null);
    return data.map((item) => RecipeTag.fromMap(item)).toList();
  }

  Future<void> delete (RecipeTag recipeTag) async {
    await databaseHelper.delete(TAG_RECIPE_TABLENAME, recipeTag.id!);
  }

  Future<void> deleteByRecipe(int recipeId) async {
    await databaseHelper.deleteWhere(TAG_RECIPE_TABLENAME, 'id_recipe = ? ', [recipeId]);
  }
}