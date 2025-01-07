import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_project/models/RecipeStep.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';
import 'package:recipes_project/usecases/GetStepsByRecipeUsecase.dart';

import '../datasources/IngredientsDatasourceTest.dart';

void main() {
  late ProviderContainer container;
  late MockDatabaseHelper mockDatabaseHelper;
  late GetStepsByRecipeUsecase getStepsByRecipeUsecase;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    container = ProviderContainer(overrides: [
      databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
    ]);
    getStepsByRecipeUsecase = container.read(getStepsByRecipeUsecaseProvider);
  });

  test('Get steps by recipe correctly', () async {
    when(() => mockDatabaseHelper.getWhere(any(), any(), any(), any())).thenAnswer((_) async => [
      {
        'description': 'Hervir el agua',
        'order_step' : 1,
        'id_recipe' : 1,
        'id': 1
      },
      {
        'description': 'Agregar la pasta cuando esté hirviendo el agua',
        'order_step' : 2,
        'id_recipe' : 1,
        'id': 2
      }
    ]);
    List<RecipeStep> steps = await getStepsByRecipeUsecase.call(1);
    expect(steps.length, 2);
  });

}