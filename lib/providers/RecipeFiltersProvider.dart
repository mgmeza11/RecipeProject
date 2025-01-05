import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/models/FilterState.dart';
import 'package:recipes_project/utils/Categories.dart';

import '../models/Tag.dart';
import '../repository/TagRepository.dart';

class RecipeFiltersNotifier extends StateNotifier<FilterState>{

  TagRepository tagRepository;

  RecipeFiltersNotifier({required this.tagRepository}):super(FilterState(totalFilters: [], currentFilters: []));

  void init(List<dynamic> currentFilters) async {
    List<RecipeFilter> availableFilters = [];
    availableFilters.add(getCategoryList(currentFilters));
    availableFilters.add(await getTags(currentFilters));
    state = FilterState(totalFilters: availableFilters, currentFilters: currentFilters);
  }

  RecipeFilter getCategoryList(List<dynamic> currentFilters){
    List<CategoryType> categories = CategoryType.values;
    List<CategoryType> categoriesSelected = currentFilters.whereType<CategoryType>().cast<CategoryType>().toList();

    List<RecipeFilterItem> items = categories.map((e) => RecipeFilterItem(data: e, selected: categoriesSelected.any((element) => element.code == e.code))).toList();
    return RecipeFilter(type: FilterType.category, items: items);

  }

  Future<RecipeFilter> getTags(List<dynamic> currentFilters) async{
    List<Tag> tagList = await tagRepository.getAll();
    List<Tag> tagSelected = currentFilters.whereType<Tag>().cast<Tag>().toList();
    
    List<RecipeFilterItem> items = tagList.map((e) => RecipeFilterItem(data: e, selected: tagSelected.any((element) => element.id == e.id))).toList();
    return RecipeFilter(type: FilterType.tag, items: items);
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
  final tagRepository = ref.read(tagRepositoryProvider);
  return RecipeFiltersNotifier(tagRepository: tagRepository);
});