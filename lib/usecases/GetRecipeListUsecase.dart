import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/repository/RecipeRepository.dart';

import '../models/Recipe.dart';

class GetRecipeListUsecase {

  RecipeRepository recipeRepository;

  GetRecipeListUsecase({required this.recipeRepository});

  Future<List<Recipe>> call() async {
    return recipeRepository.getAll();
  }
}

final getRecipeListUsecaseProvider = Provider<GetRecipeListUsecase>((ref) {
  final recipeRepository = ref.read(recipeRepositoryProvider);
  return GetRecipeListUsecase(recipeRepository: recipeRepository);
});