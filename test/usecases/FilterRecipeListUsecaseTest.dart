import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_project/models/Tag.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';
import 'package:recipes_project/usecases/FilterRecipeListUsecase.dart';
import 'package:recipes_project/utils/Categories.dart';

import '../datasources/IngredientsDatasourceTest.dart';

void main(){
  late MockDatabaseHelper mockDatabaseHelper;
  late FilterRecipeListUsecase filterRecipeListUsecase;
  late ProviderContainer container;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    container = ProviderContainer(
        overrides: [
          databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
        ]
    );
    filterRecipeListUsecase = container.read(filterRecipeListUsecaseProvider);
  });

  test('get Category Query correctly', () async {
    List<dynamic> currentFilters = [
      CategoryType.dinner,
      Tag(description: 'Rápido', id: 1),
      CategoryType.breakfast,
      Tag(description: 'Fácil', id: 2),
      Tag(description: 'Picante', id: 3),
    ];

    Map<String, dynamic> result = filterRecipeListUsecase.getCategoryQuery(currentFilters);

    expect(result['data'] is List<String>, true);
    expect((result['data'] as List<String>).length, 2);
    expect(result['query'] as String , " r.category_code IN (  ? ,  ?  ) ");
  });

  test('get Category Query empty correctly', () async {
    List<dynamic> currentFilters = [
      Tag(description: 'Rápido', id: 1),
      Tag(description: 'Fácil', id: 2),
      Tag(description: 'Picante', id: 3),
    ];

    Map<String, dynamic> result = filterRecipeListUsecase.getCategoryQuery(currentFilters);

    expect(result['data'] is List, true);
    expect((result['data'] as List).isEmpty, true);
    expect((result['query'] as String).isEmpty , true);
  });

  test('get Tag Query correctly', () async {
    List<dynamic> currentFilters = [
      CategoryType.dinner,
      Tag(description: 'Rápido', id: 1),
      CategoryType.breakfast,
      Tag(description: 'Fácil', id: 2),
      Tag(description: 'Picante', id: 3),
    ];

    Map<String, dynamic> result = filterRecipeListUsecase.getTagQuery(currentFilters);

    expect(result['data'] is List<int>, true);
    expect((result['data'] as List<int>).length, 3);
    expect(result['query'] as String , ' INNER JOIN tags_recipes tr ON tr.id_recipe = r.id WHERE tr.id_tag IN (  ? ,  ? ,  ?  ) ');

  });

  test('get Tag Query empty', () async {
    List<dynamic> currentFilters = [
      CategoryType.dinner,
      CategoryType.breakfast,
    ];

    Map<String, dynamic> result = filterRecipeListUsecase.getTagQuery(currentFilters);

    expect(result['data'] is List, true);
    expect((result['data'] as List).isEmpty, true);
    expect((result['query'] as String).isEmpty , true);

  });

  test('get keyword Query empty', () async {
    String result = filterRecipeListUsecase.getKeywordQuery("");

    expect(result.isEmpty, true);

  });

  test('get keyword Query correctly', () async {
    String result = filterRecipeListUsecase.getKeywordQuery("Pasta");

    expect(result, " (UPPER(r.name) LIKE UPPER('%Pasta%') OR UPPER(r.description) LIKE UPPER('%Pasta%')) ");

  });

  test('get complete Query correctly', () async {
    List<dynamic> currentFilters = [
      CategoryType.dinner,
      Tag(description: 'Rápido', id: 1),
      CategoryType.breakfast,
      Tag(description: 'Fácil', id: 2),
      Tag(description: 'Picante', id: 3),
    ];

    Map<String, dynamic> result = filterRecipeListUsecase.buildQuery(currentFilters, 'Pasta');

    expect(result['data'] is List<dynamic>, true);
    expect((result['data'] as List<dynamic>).length, 5);
    expect(result['query'] as String , "SELECT * FROM recipes r  INNER JOIN tags_recipes tr ON tr.id_recipe = r.id WHERE tr.id_tag IN (  ? ,  ? ,  ?  )  AND  r.category_code IN (  ? ,  ?  )  AND  (UPPER(r.name) LIKE UPPER('%Pasta%') OR UPPER(r.description) LIKE UPPER('%Pasta%')) ");

  });


}