import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_project/models/Tag.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';
import 'package:recipes_project/usecases/GetTagsUseCase.dart';

import '../datasources/IngredientsDatasourceTest.dart';

void main() {
  late ProviderContainer container;
  late MockDatabaseHelper mockDatabaseHelper;
  late GetTagsUsecase getTagsUsecase;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    container = ProviderContainer(overrides: [
      databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
    ]);
    getTagsUsecase = container.read(getTagsUsecaseProvider);
  });

  test('Get tags correctly', () async {
    when(() => mockDatabaseHelper.getAll(any())).thenAnswer((_) async => [
      {
        'description': 'Rápido',
        'id': 1
      },
      {
        'description': 'Fácil',
        'id': 2
      },
      {
        'description': 'Fitness',
        'id': 3
      }
    ]);
    List<Tag> tags = await getTagsUsecase.call();
    expect(tags.length, 3);
  });

}