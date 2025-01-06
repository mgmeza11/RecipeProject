import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_project/datasources/StepDatasource.dart';
import 'package:recipes_project/models/RecipeStep.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';

import 'IngredientsDatasourceTest.dart';

void main() {
  late ProviderContainer container;
  late MockDatabaseHelper mockDatabaseHelper;
  late StepDatasource stepDatasource;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
    container = ProviderContainer(overrides: [
      databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
    ]);
    stepDatasource = container.read(stepDatasourceProvider);
  });

  test('Add step correctly', () async {
    when(() => mockDatabaseHelper.add(any(), any())).thenAnswer((_) async => 1);

    expect(() async {
      await stepDatasource.add(RecipeStep(
          description: 'Hervir el agua',
        order: 1, idRecipe: 1,

      ));
    }, returnsNormally);
  });

  test('Add step list correctly', () async {
    when(() => mockDatabaseHelper.addList(any(), any())).thenAnswer((_) async => 1);

    expect(() async {
      await stepDatasource.addList([
        RecipeStep(
        description: 'Hervir el agua',
        order: 1, idRecipe: 1,

      )]);
    }, returnsNormally);
  });

  test('Delete step correctly', () async {
    when(() => mockDatabaseHelper.delete(any(), any()))
        .thenAnswer((_) async => 1);

    expect(() async {
      await stepDatasource.delete(RecipeStep(
        description: 'Hervir el agua',
        order: 1,
        idRecipe: 1,
        id : 1
      ));
    }, returnsNormally);
  });

  test('Get all steps by recipe correctly', () async {
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
    List<RecipeStep> steps = await stepDatasource.getByRecipe(1);
    expect(steps.length, 2);
  });

  test('Delete step by Recipe correctly', () async {
    when(() => mockDatabaseHelper.deleteWhere(any(), any(), any()))
        .thenAnswer((_) async => 1);

    expect(() async {
      await stepDatasource.deleteByRecipe(1);
    }, returnsNormally);
  });
}