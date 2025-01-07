import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_project/models/RecipeStep.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';
import 'package:recipes_project/usecases/SaveStepsUsecase.dart';

import '../datasources/IngredientsDatasourceTest.dart';

void main() {
  late ProviderContainer container;
  late MockDatabaseHelper mockDatabaseHelper;
  late SaveStepsUsecase saveStepsUsecase;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    container = ProviderContainer(overrides: [
      databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
    ]);
    saveStepsUsecase = container.read(saveStepsUsecaseProvider);
  });

  test('Save steps correctly', () async {
    when(() => mockDatabaseHelper.addList(any(), any())).thenAnswer((_) async => 1);

    expect(() async {
      await saveStepsUsecase.call([RecipeStep(
        description: 'Hervir el agua',
        order: 1, idRecipe: 1,
      )],
        1
      );
    }, returnsNormally);
  });
}