import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/datasources/TagDatasource.dart';
import 'package:recipes_project/models/RecipeTag.dart';
import 'package:recipes_project/models/Tag.dart';

class TagRepository {
  final TagDatasource tagDatasource;

  TagRepository(this.tagDatasource);

  Future<List<Tag>> getAll() async{
    return tagDatasource.getAll();
  }

  Future<List<Tag>> getByRecipe(int idRecipe) async{
    return tagDatasource.getByRecipe(idRecipe);
  }

  Future<int> addTag(Tag tag) async {
    return tagDatasource.addTag(tag);
  }

  Future<void> addRecipeTag(RecipeTag recipeTag) async {
    tagDatasource.addRecipeTag(recipeTag);
  }

  Future<void> addRecipeTagList(List<RecipeTag> recipeTag) async {
    tagDatasource.addRecipeTagList(recipeTag);
  }

}

final tagRepositoryProvider = Provider<TagRepository>((ref) {
  final tagDatasource = ref.read(tagDatasourceProvider);
  return TagRepository(tagDatasource);
});