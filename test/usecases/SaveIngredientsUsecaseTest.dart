import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_project/models/Ingredients.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';
import 'package:recipes_project/usecases/SaveIngredientsUsecase.dart';

import '../datasources/IngredientsDatasourceTest.dart';

void main(){
  late ProviderContainer container;
  late MockDatabaseHelper mockDatabaseHelper;
  late SaveIngredientsUsecase saveIngredientsUsecase;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    container = ProviderContainer(
        overrides: [
          databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
        ]
    );
    saveIngredientsUsecase = container.read(saveIngredientsUsecaseProvider);
  });

  test('Save ingredients correctly', () async {
    when(() => mockDatabaseHelper.addList('ingredients', any())).thenAnswer((_) async => 1);
    expect(() async {await saveIngredientsUsecase.call([Ingredients(name: 'Cebolla', count: '1', idRecipe: 1, unit: 'und')], 1);}, returnsNormally);

  });

}