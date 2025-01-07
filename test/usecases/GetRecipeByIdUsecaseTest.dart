import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_project/models/Recipe.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';
import 'package:recipes_project/usecases/GetRecipeByIdUsecase.dart';

import '../datasources/IngredientsDatasourceTest.dart';

void main() {
  late ProviderContainer container;
  late MockDatabaseHelper mockDatabaseHelper;
  late GetRecipeByIdUsecase getRecipeByIdUsecase;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    container = ProviderContainer(overrides: [
      databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
    ]);
    getRecipeByIdUsecase = container.read(getRecipeByIdUsecaseProvider);
  });

  test('Get recipe by id correctly', () async {
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
    Recipe? recipes = await getRecipeByIdUsecase.call(1);
    expect(recipes!.name, 'Pasta carbonara');
    expect(recipes!.id, 1);
  });
}