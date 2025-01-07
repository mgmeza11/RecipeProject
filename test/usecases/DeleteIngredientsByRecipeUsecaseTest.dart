import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';
import 'package:recipes_project/usecases/DeleteIngredientsByRecipeUsecase.dart';

import '../datasources/IngredientsDatasourceTest.dart';

void main(){
  late ProviderContainer container;
  late MockDatabaseHelper mockDatabaseHelper;
  late DeleteIngredientsByRecipeUsecase deleteIngredientsByRecipeUsecase;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    container = ProviderContainer(
        overrides: [
          databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
        ]
    );
    deleteIngredientsByRecipeUsecase = container.read(deleteIngredientsByRecipeUsecaseProvider);
  });

  test('Delete ingredients by recipe correctly', () async {
    when(() => mockDatabaseHelper.deleteWhere('ingredients', 'id_recipe = ? ', any())).thenAnswer((_) async => 1);
    expect(() async {await deleteIngredientsByRecipeUsecase.call(1);}, returnsNormally);
  });

}