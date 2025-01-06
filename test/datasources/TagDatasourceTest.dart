import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_project/datasources/TagDatasource.dart';
import 'package:recipes_project/models/RecipeTag.dart';
import 'package:recipes_project/models/Tag.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';

import 'IngredientsDatasourceTest.dart';

void main() {
  late ProviderContainer container;
  late MockDatabaseHelper mockDatabaseHelper;
  late TagDatasource tagDatasource;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    container = ProviderContainer(overrides: [
      databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
    ]);
    tagDatasource = container.read(tagDatasourceProvider);
  });

  test('Add tag correctly', () async {
    when(() => mockDatabaseHelper.add(any(), any())).thenAnswer((_) async => 1);

    expect(() async {
      await tagDatasource.addTag(Tag(description: 'Rápido'));
    }, returnsNormally);
  });

  test('Add recipe tag correctly', () async {
    when(() => mockDatabaseHelper.add(any(), any())).thenAnswer((_) async => 1);

    expect(() async {
      await tagDatasource.addRecipeTag(RecipeTag(idRecipe: 1, idTag: 1));
    }, returnsNormally);
  });

  test('Add recipe tag list correctly', () async {
    when(() => mockDatabaseHelper.addList(any(), any())).thenAnswer((_) async => 1);

    expect(() async {
      await tagDatasource.addRecipeTagList([
        RecipeTag(idRecipe: 1, idTag: 1),
        RecipeTag(idRecipe: 1, idTag: 2),
      ]);
    }, returnsNormally);
  });

  test('Delete tag by recipe correctly', () async {
    when(() => mockDatabaseHelper.deleteWhere(any(), any(), any()))
        .thenAnswer((_) async => 1);

    expect(() async {
      await tagDatasource.deleteByRecipe(1);
    }, returnsNormally);
  });

  test('Get all tags by recipe correctly', () async {
    when(() => mockDatabaseHelper.queryById(any(), any())).thenAnswer((_) async => [
      {
        'description': 'Rápido',
        'id': 1
      },
      {
        'description': 'Fácil',
        'id': 2
      }
    ]);
    List<Tag> tags = await tagDatasource.getByRecipe(1);
    expect(tags.length, 2);
  });

  test('Get all tags correctly', () async {
    when(() => mockDatabaseHelper.getAll(any())).thenAnswer((_) async => [
      {
        'description': 'Rápido',
        'id': 1
      },
      {
        'description': 'Fácil',
        'id': 2
      },
      {
        'description': 'Fitness',
        'id': 3
      }
    ]);
    List<Tag> tags = await tagDatasource.getAll();
    expect(tags.length, 3);
  });

}