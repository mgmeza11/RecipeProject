import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/usecases/DeleteRecipeUsecase.dart';
import 'package:recipes_project/usecases/GetRecipeByIdUsecase.dart';
import '../models/Recipe.dart';
import '../utils/CustomException.dart';

class RecipeDetailNotifier extends StateNotifier<AsyncValue<Recipe>>{
  DeleteRecipeUsecase deleteRecipeUsecase;
  GetRecipeByIdUsecase getRecipeByIdUsecase;

  RecipeDetailNotifier({ required this.deleteRecipeUsecase, required this.getRecipeByIdUsecase}): super(const AsyncValue.loading());

  void init(int idRecipe) async {
      Recipe? recipe = await getRecipeByIdUsecase.call(idRecipe);
      if(recipe != null){
        state = AsyncValue.data(recipe);
      }else{
        state = AsyncValue.error(CustomException(CustomExceptionTypes.notFound.message), StackTrace.empty);
      }
  }

  void deleteRecipe(int idRecipe) async{
    await deleteRecipeUsecase.call(idRecipe);
  }

}

final recipeDetailProvider = StateNotifierProvider<RecipeDetailNotifier, AsyncValue<Recipe>>((ref) {
  final deleteRecipeUseCase = ref.read(deleteRecipeUsecaseProvider);
  final getRecipebyIdUsecase = ref.read(getRecipeByIdUsecaseProvider);
  return RecipeDetailNotifier(deleteRecipeUsecase: deleteRecipeUseCase, getRecipeByIdUsecase: getRecipebyIdUsecase);
});