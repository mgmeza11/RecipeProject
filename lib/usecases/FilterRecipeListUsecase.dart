import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/utils/DatabaseUtils.dart';

import '../models/Recipe.dart';
import '../models/Tag.dart';
import '../repository/RecipeRepository.dart';
import '../utils/Categories.dart';

class FilterRecipeListUsecase {

  RecipeRepository recipeRepository;

  String query = "query";
  String data = "data";

  FilterRecipeListUsecase({required this.recipeRepository});

  Future<List<Recipe>> call(List<dynamic> filters, String keyword) async {
    Map<String, dynamic> queryData = buildQuery(filters, keyword);
    return recipeRepository.filterList(queryData[query], queryData[data]);
  }


  Map<String, dynamic> buildQuery(List<dynamic> filters, String keyword){
    List<dynamic> whereArgs = [];
    Map <String, dynamic> tagQueryData = getTagQuery(filters);
    String tagQuery = tagQueryData[query] as String;
    Map <String, dynamic> categoryQueryData = getCategoryQuery(filters);
    String categoryQuery = categoryQueryData[query] as String;

    StringBuffer sqlQuery = StringBuffer('SELECT * FROM $RECIPES_TABLENAME r ');
    sqlQuery.write(tagQuery.isNotEmpty ? tagQuery : ' WHERE ');
    if(tagQuery.isNotEmpty && (categoryQuery.isNotEmpty || keyword.isNotEmpty)) sqlQuery.write(" AND ");
    sqlQuery.write(categoryQuery);
    if(keyword.isNotEmpty && categoryQuery.isNotEmpty) sqlQuery.write(" AND ");
    sqlQuery.write(getKeywordQuery(keyword));

    whereArgs.addAll(tagQueryData[data]);
    whereArgs.addAll(categoryQueryData[data]);

    return { query : sqlQuery.toString() , data : whereArgs};
  }

  String getKeywordQuery(String keyword){
    return keyword.isNotEmpty ? " (UPPER(r.name) LIKE UPPER('%$keyword%') OR UPPER(r.description) LIKE UPPER('%$keyword%')) " : "";
  }

  Map <String, dynamic> getCategoryQuery(List<dynamic> filters){
    List<String> categories = filters.whereType<CategoryType>().map((e) => e.code).toList();
    if(categories.isNotEmpty){
      String argumentsQuery = " ? , " * categories.length;
      String querySql = " r.category_code IN ( ${argumentsQuery.substring(0, argumentsQuery.length -2)} ) ";

      return {query : querySql , data:  categories};
    }
    return {query :'' , data : []};
  }

  Map <String, dynamic> getTagQuery(List<dynamic> filters){
    List<int> tags = filters.whereType<Tag>().map((e) => e.id!).toList();
    if(tags.isNotEmpty){
      String argumentsQuery = " ? , " * tags.length;
      String querySql = ' INNER JOIN $TAG_RECIPE_TABLENAME tr ON tr.id_recipe = r.id WHERE tr.id_tag IN ( ${argumentsQuery.substring(0, argumentsQuery.length -2)} ) ';

      return {query : querySql, data : tags};
    }
    return {query :'' , data : []};
  }

}

final filterRecipeListUsecaseProvider = Provider<FilterRecipeListUsecase>((ref) {
  final recipeRepository = ref.read(recipeRepositoryProvider);
  return FilterRecipeListUsecase(recipeRepository: recipeRepository);
});