import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/models/Recipe.dart';
import 'package:recipes_project/models/RecipeListState.dart';
import 'package:recipes_project/usecases/FilterRecipeListUsecase.dart';
import 'package:recipes_project/utils/CustomException.dart';
import '../repository/RecipeRepository.dart';

class RecipeListNotifier extends StateNotifier<AsyncValue<RecipeListState>>{
  final RecipeRepository repository;
  final FilterRecipeListUsecase filterRecipeListUsecase;
  RecipeListNotifier(this.repository, this.filterRecipeListUsecase): super(const AsyncValue.loading());
  Future<void> getAll() async {
    try {
      final items = await repository.getAll();
      if(items.isEmpty){
        throw CustomException(CustomExceptionTypes.empty.message);
      }
      state = AsyncValue.data(RecipeListState(listRecipe: items, currentFilters: [], keyword: ""));
    } catch (e) {
      state = AsyncValue.error(CustomExceptionTypes.technicalError.message, StackTrace.empty);
    }
  }

  Future<List<Recipe>> filter(List<dynamic> filterList, String keyword) async {
    return await filterRecipeListUsecase.call(filterList, keyword);
  }

  void updateFilters(List<dynamic> filterList) async{
    List<Recipe> recipeFilter = await filter(filterList, state.value!.keyword);
    state = AsyncValue.data(state.value!.copyWith(currentFilters: filterList, listRecipe: recipeFilter));
  }

  void deleteFilter(int index)async {
    List<dynamic> newFilters = state.value!.currentFilters;
    newFilters.removeAt(index);
    if(newFilters.isNotEmpty){
      List<Recipe> recipeFilter = await filter(newFilters, state.value!.keyword);
      state = AsyncValue.data(state.value!.copyWith(currentFilters: newFilters, listRecipe: recipeFilter));
    }else {
      getAll();
    }

  }

  void updateKeyword(String keyword) async{
    if(keyword.isEmpty && state.value!.currentFilters.isEmpty){
      getAll();
      return;
    }
    List<Recipe> recipeFilter = await filter(state.value!.currentFilters, keyword);
    state = AsyncValue.data(state.value!.copyWith(listRecipe: recipeFilter, keyword: keyword));
  }

  void searchByKeyword() async {
    List<Recipe> recipeFilter = await filter(state.value!.currentFilters, state.value!.keyword);
    state = AsyncValue.data(state.value!.copyWith(listRecipe: recipeFilter));
  }
}

final recipeListProvider = StateNotifierProvider<RecipeListNotifier, AsyncValue<RecipeListState>>((ref) {
    final repository = ref.read(recipeRepositoryProvider);
    final filterRecipeUseCase = ref.read(filterRecipeListUsecaseProvider);
    return RecipeListNotifier(repository,filterRecipeUseCase);
});
