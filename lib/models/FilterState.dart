
class FilterState {
  List<RecipeFilter> totalFilters = [];

  List<dynamic> currentFilters = [];

  FilterState({required this.totalFilters, required this.currentFilters});

  FilterState copyWith({List<RecipeFilter>? totalFilters, List<dynamic>? currentFilters}){
    return FilterState(totalFilters: totalFilters?? this.totalFilters, currentFilters: currentFilters ?? this.currentFilters);
  }
}

class RecipeFilter{
  List<RecipeFilterItem> items = [];
  FilterType type;

  RecipeFilter({required this.type, required this.items});
}

class RecipeFilterItem{
  dynamic data;
  bool selected = false;

  RecipeFilterItem({required this.data, required this.selected});

  RecipeFilterItem copyWith({dynamic? data, bool? selected}){
    return RecipeFilterItem(data: data?? this.data, selected: selected?? this.selected);
  }
}

enum FilterType{
  category(name: "Categoría"),
  tag(name: "Etiqueta");

  final String name;

  const FilterType({required this.name});

}