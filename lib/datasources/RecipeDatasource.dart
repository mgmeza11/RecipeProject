import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/models/Recipe.dart';
import 'package:recipes_project/utils/DatabaseUtils.dart';

import '../services/DatabaseHelper.dart';

class RecipeDatasource{

  final DatabaseHelper databaseHelper;

  RecipeDatasource(this.databaseHelper);

  Future<int> insert(Recipe recipe) async {
    return await databaseHelper.add(RECIPES_TABLENAME, recipe.toMap());
  }

  Future<void> update (Recipe recipe) async {
    await databaseHelper.update(RECIPES_TABLENAME, recipe.toMap());
  }

  Future<void> delete (Recipe recipe) async {
    await databaseHelper.delete(RECIPES_TABLENAME, recipe.id!!);
  }

  Future<List<Recipe>> getAll() async {
    final data = await databaseHelper.getAll(RECIPES_TABLENAME);
    return data.map((item) => Recipe.fromMap(item)).toList();
  }

  Future<List<Recipe>> getFilteredList(String where, List<dynamic> whereArgs) async {
    final data = await databaseHelper.query(where, whereArgs);
    return data.map((item) => Recipe.fromMap(item)).toList();
  }

  Future<Recipe?> findById(int idRecipe) async {
    final data = await databaseHelper.findById(RECIPES_TABLENAME, idRecipe);
    return (data != null)? Recipe.fromMap(data) : null;
  }

}
final recipeDatasourceProvider = Provider<RecipeDatasource>((ref) {
  final databaseHelper = ref.read(databaseHelperProvider);
  return RecipeDatasource(databaseHelper);
});