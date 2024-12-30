import 'package:recipes_project/models/Ingredients.dart';
import 'package:recipes_project/utils/DatabaseUtils.dart';

import '../services/DatabaseHelper.dart';

class IngredientsDatasource {
  final DatabaseHelper databaseHelper;

  IngredientsDatasource(this.databaseHelper);

  Future<void> insert(Ingredients tag) async {
    await databaseHelper.add(INGREDIENTS_TABLENAME, tag.toMap());
  }

  Future<List<Ingredients>> getByRecipe(int recipeId) async {
    final data = await databaseHelper.getWhere(INGREDIENTS_TABLENAME, 'id_recipe = ? ', [recipeId]);
    return data.map((item) => Ingredients.fromMap(item)).toList();
  }

  Future<void> delete (Ingredients ingredients) async {
    await databaseHelper.delete(INGREDIENTS_TABLENAME, ingredients.id!!);
  }
}