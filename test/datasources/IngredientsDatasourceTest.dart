import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes_project/datasources/IngredientsDatasource.dart';
import 'package:recipes_project/models/Ingredients.dart';
import 'package:recipes_project/services/DatabaseHelper.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main(){
  late ProviderContainer container;
  late MockDatabaseHelper mockDatabaseHelper;
  late IngredientsDatasource ingredientsDatasource;

  setUp(() async {
    mockDatabaseHelper = MockDatabaseHelper();
   container = ProviderContainer(
     overrides: [
       databaseHelperProvider.overrideWith((ref) => mockDatabaseHelper)
     ]
   );
   ingredientsDatasource = container.read(ingredientsDatasourceProvider);
  });

  test('Assert get ingredients by recipe', () async {
    when(() => mockDatabaseHelper.getWhere('ingredients', 'id_recipe = ? ', [1], null)).thenAnswer((_) async => [
      {'name' : 'Cebolla', 'id' : 1, 'id_recipe': 1, 'count': '1/2', 'unit' : 'und'}
    ]);

    List<Ingredients> ingredients = await ingredientsDatasource.getByRecipe(1);
    expect(ingredients.length, 1);
    expect(ingredients[0].name, 'Cebolla');

  });

  test('Insert ingredients correctly', () async {
    when(() => mockDatabaseHelper.add('ingredients', any())).thenAnswer((_) async => 1);
    expect(() async {await ingredientsDatasource.insert(Ingredients(name: 'Cebolla', count: '1', idRecipe: 1, unit: 'und'));}, returnsNormally);

  });

  test('Add ingredients list correctly', () async {
    when(() => mockDatabaseHelper.addList('ingredients', any())).thenAnswer((_) async => 1);
    expect(() async {await ingredientsDatasource.addList([Ingredients(name: 'Cebolla', count: '1', idRecipe: 1, unit: 'und')]);}, returnsNormally);

  });

  test('Delete ingredient correctly', () async {
    when(() => mockDatabaseHelper.delete('ingredients', any())).thenAnswer((_) async => 1);
    expect(() async {await ingredientsDatasource.delete(Ingredients(name: 'Cebolla', count: '1', idRecipe: 1, unit: 'und', id: 1));}, returnsNormally);

  });

  test('Delete ingredients by recipe correctly', () async {
    when(() => mockDatabaseHelper.deleteWhere('ingredients', 'id_recipe = ? ', any())).thenAnswer((_) async => 1);
    expect(() async {await ingredientsDatasource.deleteByRecipe(1);}, returnsNormally);

  });

}