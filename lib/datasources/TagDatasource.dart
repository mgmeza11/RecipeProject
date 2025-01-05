import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/models/RecipeTag.dart';
import 'package:recipes_project/models/Tag.dart';
import 'package:recipes_project/utils/DatabaseUtils.dart';

import '../services/DatabaseHelper.dart';

class TagDatasource {
  final DatabaseHelper databaseHelper;

  TagDatasource(this.databaseHelper);

  Future<List<Tag>> getAll() async {
    final data = await databaseHelper.getAll(TAGS_TABLENAME);
    return data.map((item) => Tag.fromMap(item)).toList();
  }

  Future<List<Tag>> getByRecipe(int recipeId) async {
    String query = 'SELECT * FROM $TAGS_TABLENAME t LEFT JOIN $TAG_RECIPE_TABLENAME tr ON t.id = tr.id_tag WHERE tr.id_recipe = ? ';
    final data = await databaseHelper.queryById(query, recipeId);
    return data.map((item) => Tag.fromMap(item)).toList();
  }

  Future<void> deleteByRecipe(int recipeId) async {
    await databaseHelper.deleteWhere(TAG_RECIPE_TABLENAME, 'id_recipe = ? ', [recipeId]);
  }

  Future<int> addTag(Tag tag) async {
    return await databaseHelper.add(TAGS_TABLENAME, tag.toMap());
  }

  //Recipe-Tag
  Future<void> addRecipeTag(RecipeTag recipeTag) async {
    await databaseHelper.add(TAG_RECIPE_TABLENAME, recipeTag.toMap());
  }

  Future<void> addRecipeTagList(List<RecipeTag> recipeTags) async {
    List<Map<String, dynamic>> recipeTagMap = recipeTags.map((e) => e.toMap()).toList();
    await databaseHelper.addList(TAG_RECIPE_TABLENAME, recipeTagMap);
  }
}

final tagDatasourceProvider = Provider<TagDatasource>((ref) {
  final databaseHelper = ref.read(databaseHelperProvider);
  return TagDatasource(databaseHelper);
});