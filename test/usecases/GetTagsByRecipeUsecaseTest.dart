import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_project/models/Tag.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';
import 'package:recipes_project/usecases/GetTagsByRecipeUsecase.dart';

import '../datasources/IngredientsDatasourceTest.dart';

void main() {
  late ProviderContainer container;
  late MockDatabaseHelper mockDatabaseHelper;
  late GetTagsByRecipeUsecase getTagsByRecipeUsecase;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    container = ProviderContainer(overrides: [
      databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
    ]);
    getTagsByRecipeUsecase = container.read(getTagsByRecipeUsecaseProvider);
  });

  test('Get tags by recipe correctly', () async {
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
    List<Tag> tags = await getTagsByRecipeUsecase.call(1);
    expect(tags.length, 2);
  });

}