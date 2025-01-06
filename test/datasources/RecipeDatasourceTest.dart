import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_project/datasources/RecipeDatasource.dart';
import 'package:recipes_project/models/Recipe.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';

import 'IngredientsDatasourceTest.dart';

void main() {
  late ProviderContainer container;
  late MockDatabaseHelper mockDatabaseHelper;
  late RecipeDatasource recipeDatasource;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    container = ProviderContainer(overrides: [
      databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
    ]);
    recipeDatasource = container.read(recipeDatasourceProvider);
  });

  test('Add recipe correctly', () async {
    when(() => mockDatabaseHelper.add(any(), any())).thenAnswer((_) async => 1);

    expect(() async {
      await recipeDatasource.insert(Recipe(
          name: 'Pasta',
          categoryCode: 'DINNER',
          ingredients: [],
          steps: [],
          tags: []));
    }, returnsNormally);
  });

  test('Delete recipe correctly', () async {
    when(() => mockDatabaseHelper.delete(any(), any()))
        .thenAnswer((_) async => 1);

    expect(() async {
      await recipeDatasource.delete(1);
    }, returnsNormally);
  });

  test('Get all recipe correctly', () async {
    when(() => mockDatabaseHelper.getAll(any())).thenAnswer((_) async => [
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
        ]);
    List<Recipe> recipes = await recipeDatasource.getAll();
    expect(recipes.length, 2);
  });

  test('Filter recipe correctly', () async {
    when(() => mockDatabaseHelper.query(any(), any())).thenAnswer((_) async => [
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
    ]);
    List<Recipe> recipes = await recipeDatasource.getFilteredList("SELECT * FROM recipes r WHERE (UPPER(r.name) LIKE UPPER('Pasta') OR UPPER(r.description) LIKE UPPER('%Pasta%'))", []);
    expect(recipes.length, 2);
    expect(recipes[0].name, 'Pasta carbonara');
  });

  test('Find recipe correctly', () async {
    when(() => mockDatabaseHelper.findById(any(), any())).thenAnswer((_) async =>
      {
        'name': 'Pasta carbonara',
        'category_code': 'DINNER',
        'description': '',
        'image_path': '',
        'ingredients': [],
        'steps': [],
        'tags': [],
        'id': 1
      }
    );
    Recipe? recipes = await recipeDatasource.findById(1);
    expect(recipes!.name, 'Pasta carbonara');
    expect(recipes!.id, 1);
  });
}
