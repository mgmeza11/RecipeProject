import 'package:recipes_project/models/Recipe.dart';
import 'package:recipes_project/utils/DatabaseUtils.dart';

import '../services/DatabaseHelper.dart';

class RecipeDatasource{

  final DatabaseHelper databaseHelper;

  RecipeDatasource(this.databaseHelper);

  Future<void> insert(Recipe recipe) async {
    await databaseHelper.add(RECIPES_TABLENAME, recipe.toMap());
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

  Future<List<Recipe>> getFilteredList(String where, List<Object> whereArgs) async {
    final data = await databaseHelper.getWhere(RECIPES_TABLENAME, where, whereArgs);
    return data.map((item) => Recipe.fromMap(item)).toList();
  }

}