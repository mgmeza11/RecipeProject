import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_project/models/Tag.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';
import 'package:recipes_project/usecases/SaveTagUsecase.dart';

import '../datasources/IngredientsDatasourceTest.dart';

void main() {
  late ProviderContainer container;
  late MockDatabaseHelper mockDatabaseHelper;
  late SaveTagUsecase saveTagUsecase;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    container = ProviderContainer(overrides: [
      databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
    ]);
    saveTagUsecase = container.read(saveTagUsecaseProvider);
  });

  test('Save tag correctly', () async {
    when(() => mockDatabaseHelper.add(any(), any())).thenAnswer((_) async => 1);

    expect(() async {
      await saveTagUsecase.call(Tag(description: 'Rápido'));
    }, returnsNormally);
  });
}