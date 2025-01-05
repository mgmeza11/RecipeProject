import 'Recipe.dart';

class RecipeListState {
  List<Recipe> listRecipe = [];
  List<dynamic> currentFilters = [];
  String keyword = "";

  RecipeListState({required this.listRecipe, required this.currentFilters, required this.keyword});

  RecipeListState copyWith({List<Recipe>? listRecipe, List<dynamic>? currentFilters, String? keyword}){
    return RecipeListState(listRecipe: listRecipe?? this.listRecipe, currentFilters: currentFilters?? this.currentFilters, keyword: keyword?? this.keyword);
  }
}