import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_project/models/Ingredients.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';
import 'package:recipes_project/usecases/GetIngredientsByRecipeUsecase.dart';

import '../datasources/IngredientsDatasourceTest.dart';

void main(){
  late ProviderContainer container;
  late MockDatabaseHelper mockDatabaseHelper;
  late GetIngredientsByRecipeUsecase getIngredientsByRecipeUsecase;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    container = ProviderContainer(
        overrides: [
          databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
        ]
    );
    getIngredientsByRecipeUsecase = container.read(getIngredientsByRecipeUsecaseProvider);
  });

  test('Get ingredients by recipe correctly', () async {
    when(() => mockDatabaseHelper.getWhere('ingredients', 'id_recipe = ? ', [1], null)).thenAnswer((_) async => [
      {'name' : 'Cebolla', 'id' : 1, 'id_recipe': 1, 'count': '1/2', 'unit' : 'und'}
    ]);

    List<Ingredients> ingredients = await getIngredientsByRecipeUsecase.call(1);
    expect(ingredients.length, 1);
    expect(ingredients[0].name, 'Cebolla');

  });

}