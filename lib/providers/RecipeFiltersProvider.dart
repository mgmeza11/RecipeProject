import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/models/FilterState.dart';
import 'package:recipes_project/usecases/GetFilterlistUsecase.dart';

class RecipeFiltersNotifier extends StateNotifier<FilterState>{

  GetFilterListUsecase getFilterListUsecase;
  RecipeFiltersNotifier({required this.getFilterListUsecase}):super(FilterState(totalFilters: [], currentFilters: []));

  void init(List<dynamic> currentFilters) async {
    List<RecipeFilter> availableFilters = await getFilterListUsecase.call(currentFilters);
    state = FilterState(totalFilters: availableFilters, currentFilters: currentFilters);
  }

  void updateSelectedStatus(bool status, int indexTitle, int indexChildren){
    List<RecipeFilter> newFilters = state.totalFilters;
    RecipeFilterItem itemToUpdate = newFilters[indexTitle].items[indexChildren];
    newFilters[indexTitle].items[indexChildren] = itemToUpdate.copyWith(selected : status);
    state = state.copyWith(totalFilters: newFilters);

  }
  
  List<dynamic> getSelectedFilters(){
    return state.totalFilters.expand((element) => element.items).where((element) => element.selected == true).map((e) => e.data).toList();
  }

}

final recipeFilterProvider = StateNotifierProvider<RecipeFiltersNotifier, FilterState>((ref) {
  final getFilterListUsecase = ref.read(getFilterListUsecaseProvider);
  return RecipeFiltersNotifier(getFilterListUsecase: getFilterListUsecase);
});