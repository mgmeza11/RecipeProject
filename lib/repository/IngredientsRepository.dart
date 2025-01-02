import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/datasources/IngredientsDatasource.dart';
import 'package:recipes_project/models/Ingredients.dart';

class IngredientsRepository{
  final IngredientsDatasource ingredientsDatasource;

  IngredientsRepository(this.ingredientsDatasource);

  Future<List<Ingredients>> getByRecipe(int idRecipe) async{
    return ingredientsDatasource.getByRecipe(idRecipe);
  }

  Future<void> addList(List<Ingredients> ingredientsList) async {
    ingredientsDatasource.addList(ingredientsList);
  }
}

final ingredientsRepositoryProvider = Provider<IngredientsRepository>((ref) {
  final ingredientsDatasource = ref.read(ingredientsDatasourceProvider);
  return IngredientsRepository(ingredientsDatasource);
});