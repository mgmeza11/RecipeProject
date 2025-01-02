import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/models/Recipe.dart';
import 'package:recipes_project/utils/CustomException.dart';

import '../repository/RecipeRepository.dart';

class RecipeListNotifier extends StateNotifier<AsyncValue<List<Recipe>>>{
  final RecipeRepository repository;
  RecipeListNotifier(this.repository): super(const AsyncValue.loading());
  Future<void> getAll() async {
    try {
      final items = await repository.getAll();
      if(items.isEmpty){
        throw CustomException(CustomExceptionTypes.empty.message);
      }
      state = AsyncValue.data(items);
    } catch (e) {
      print(e.toString());
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }
}

final recipeListProvider = StateNotifierProvider<RecipeListNotifier, AsyncValue<List<Recipe>>>((ref) {
    final repository = ref.read(recipeRepositoryProvider);
    return RecipeListNotifier(repository);
});
