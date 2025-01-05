import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/FilterState.dart';
import '../models/Tag.dart';
import '../repository/TagRepository.dart';
import '../utils/Categories.dart';

class GetFilterListUsecase {

  TagRepository tagRepository;

  GetFilterListUsecase({required this.tagRepository});

  Future<List<RecipeFilter>> call(List<dynamic> currentFilters) async {
    List<RecipeFilter> availableFilters = [];
    availableFilters.add(getCategoryList(currentFilters));
    availableFilters.add(await getTags(currentFilters));
    return availableFilters;
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
}

final getFilterListUsecaseProvider = Provider<GetFilterListUsecase>((ref) {
  final tagRepository = ref.read(tagRepositoryProvider);
  return GetFilterListUsecase(tagRepository: tagRepository);
});