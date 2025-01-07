import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';
import 'package:recipes_project/usecases/DeleteTagsByRecipeUsecase.dart';

import '../datasources/IngredientsDatasourceTest.dart';

void main(){
  late ProviderContainer container;
  late MockDatabaseHelper mockDatabaseHelper;
  late DeleteTagsByRecipeUsecase deleteTagsByRecipeUsecase;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    container = ProviderContainer(
        overrides: [
          databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
        ]
    );
    deleteTagsByRecipeUsecase = container.read(deleteTagsByRecipeUsecaseProvider);
  });

  test('Delete tags by recipe correctly', () async {
    when(() => mockDatabaseHelper.deleteWhere(any(), 'id_recipe = ? ', any())).thenAnswer((_) async => 1);
    expect(() async {await deleteTagsByRecipeUsecase.call(1);}, returnsNormally);
  });

}