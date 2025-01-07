import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_project/models/Recipe.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';
import 'package:recipes_project/usecases/GetRecipeListUsecase.dart';

import '../datasources/IngredientsDatasourceTest.dart';

void main() {
  late ProviderContainer container;
  late MockDatabaseHelper mockDatabaseHelper;
  late GetRecipeListUsecase getRecipeListUsecase;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    container = ProviderContainer(overrides: [
      databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
    ]);
    getRecipeListUsecase = container.read(getRecipeListUsecaseProvider);
  });

  test('Get recipe list correctly', () async {
    when(() => mockDatabaseHelper.getAll(any())).thenAnswer((_) async =>
    [
      {
        'name': 'Pasta carbonara',
        'category_code': 'DINNER',
        'description': '',
        'image_path': '',
        'ingredients': [],
        'steps': [],
        'tags': [],
        'id': 1
      },
      {
        'name': 'Pasta Bolognesa',
        'category_code': 'DINNER',
        'description': '',
        'image_path': '',
        'ingredients': [],
        'steps': [],
        'tags': [],
        'id': 2
      }
        ]
    );
    List<Recipe> recipes = await getRecipeListUsecase.call();
    expect(recipes.length, 2);
  });
}