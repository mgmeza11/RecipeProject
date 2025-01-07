import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';
import 'package:recipes_project/usecases/DeleteStepsByRecipeUsecase.dart';

import '../datasources/IngredientsDatasourceTest.dart';

void main(){
  late ProviderContainer container;
  late MockDatabaseHelper mockDatabaseHelper;
  late DeleteStepsByRecipeUsecase deleteStepsByRecipeUsecase;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    container = ProviderContainer(
        overrides: [
          databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
        ]
    );
    deleteStepsByRecipeUsecase = container.read(deleteStepsByRecipeUsecaseProvider);
  });

  test('Delete steps by recipe correctly', () async {
    when(() => mockDatabaseHelper.deleteWhere(any(), 'id_recipe = ? ', any())).thenAnswer((_) async => 1);
    expect(() async {await deleteStepsByRecipeUsecase.call(1);}, returnsNormally);
  });

}