import 'package:recipes_project/models/Tag.dart';
import 'package:recipes_project/utils/DatabaseUtils.dart';

import '../services/DatabaseHelper.dart';

class TagDatasource {
  final DatabaseHelper databaseHelper;

  TagDatasource(this.databaseHelper);

  Future<void> insert(Tag tag) async {
    await databaseHelper.add(TAGS_TABLENAME, tag.toMap());
  }

  Future<List<Tag>> getAll() async {
    final data = await databaseHelper.getAll(TAGS_TABLENAME);
    return data.map((item) => Tag.fromMap(item)).toList();
  }

  Future<void> deleteByRecipe(int recipeId) async {
    await databaseHelper.deleteWhere(TAGS_TABLENAME, 'id_recipe = ? ', [recipeId]);
  }
}