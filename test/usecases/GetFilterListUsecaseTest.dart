import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_project/models/FilterState.dart';
import 'package:recipes_project/models/Tag.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';
import 'package:recipes_project/usecases/GetFilterlistUsecase.dart';
import 'package:recipes_project/utils/Categories.dart';

import '../datasources/IngredientsDatasourceTest.dart';

void main(){
  late MockDatabaseHelper mockDatabaseHelper;
  late GetFilterListUsecase getFilterListUsecase;
  late ProviderContainer container;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    container = ProviderContainer(
        overrides: [
          databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
        ]
    );
    getFilterListUsecase = container.read(getFilterListUsecaseProvider);
  });

  test('get Category filters correctly', () async {
    List<dynamic> currentFilters = [
      CategoryType.dinner,
      Tag(description: 'Rápido', id: 1),
      CategoryType.breakfast,
      Tag(description: 'Fácil', id: 2),
      Tag(description: 'Picante', id: 3),
    ];

    RecipeFilter filter = getFilterListUsecase.getCategoryList(currentFilters);
    expect(filter.items.length, 4);
    expect(filter.items[0].data is CategoryType, true);
    expect((filter.items[3]).selected , true);
  });

  test('get Tag filters correctly', () async {
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
        'description': 'Picante',
        'id': 3
      },
      {
        'description': 'Principiante',
        'id': 4
      }
    ]);
    List<dynamic> currentFilters = [
      CategoryType.dinner,
      Tag(description: 'Rápido', id: 1),
      CategoryType.breakfast,
      Tag(description: 'Fácil', id: 2),
      Tag(description: 'Picante', id: 3),
    ];

    RecipeFilter filter = await getFilterListUsecase.getTags(currentFilters);
    expect(filter.items.length, 4);
    expect(filter.items[0].data is Tag, true);
    expect((filter.items[0]).selected , true);
    expect((filter.items[3]).selected , false);
  });

  test('call usecase correctly', () async {
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
        'description': 'Picante',
        'id': 3
      },
      {
        'description': 'Principiante',
        'id': 4
      }
    ]);

    
    List<dynamic> currentFilters = [
      CategoryType.dinner,
      Tag(description: 'Rápido', id: 1),
      CategoryType.breakfast,
      Tag(description: 'Fácil', id: 2),
      Tag(description: 'Picante', id: 3),
    ];

    List<RecipeFilter> filter = await getFilterListUsecase.call(currentFilters);
    expect(filter.length, 2);
    expect(filter[0].items[0].data is CategoryType, true);
    expect((filter[0].items[3]).selected , true);
  });

}