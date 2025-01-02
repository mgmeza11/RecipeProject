import '../datasources/RecipeDatasource.dart';
import '../models/Recipe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeRepository {
  final RecipeDatasource recipeDatasource;

  RecipeRepository(this.recipeDatasource);

  Future<List<Recipe>> getAll() async {
    return recipeDatasource.getAll();
  }

  Future<Recipe?> findById(int idRecipe) async{
    return recipeDatasource.findById(idRecipe);
  }

  Future<int> insert(Recipe recipe) async{
    return recipeDatasource.insert(recipe);
  }

}

final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  final recipeDatasource = ref.read(recipeDatasourceProvider);
  return RecipeRepository(recipeDatasource);
});