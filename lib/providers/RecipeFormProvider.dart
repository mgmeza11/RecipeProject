import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recipes_project/models/Ingredients.dart';
import 'package:recipes_project/models/RecipeStep.dart';
import 'package:recipes_project/models/RecipeTag.dart';
import 'package:recipes_project/models/Tag.dart';
import 'package:recipes_project/repository/IngredientsRepository.dart';
import 'package:recipes_project/repository/RecipeStepRepository.dart';
import 'package:recipes_project/repository/TagRepository.dart';
import 'package:recipes_project/usecases/SaveRecipeUsecase.dart';
import 'package:recipes_project/utils/Categories.dart';
import 'package:recipes_project/utils/CustomException.dart';

import '../models/Recipe.dart';
import '../repository/RecipeRepository.dart';
import '../usecases/GetRecipeByIdUsecase.dart';

class RecipeFormNotifier extends StateNotifier<AsyncValue<Recipe>>{

  GetRecipeByIdUsecase getRecipeByIdUsecase;
  SaveRecipeUsecase saveRecipeUsecase;
  final ImagePicker imagePicker = ImagePicker();

  RecipeFormNotifier({required this.getRecipeByIdUsecase, required this.saveRecipeUsecase}): super(const AsyncValue.loading());

  void init(int? idRecipe) async {
    if(idRecipe == null){
      state = AsyncValue.data(Recipe(name: '', categoryCode: CategoryType.breakfast.code, ingredients: [], steps: [], tags: []));
    } else {
      Recipe? recipe = await getRecipeByIdUsecase.call(idRecipe);
      if(recipe != null){
        state = AsyncValue.data(recipe);
      }else{
        state = AsyncValue.error(CustomException(CustomExceptionTypes.notFound.message), StackTrace.empty);
      }
    }
  }

  Future<void> saveData() async {
    try{
      Recipe recipe = state.value!;
      await saveRecipeUsecase.call(recipe);
    }catch(e){
      state = AsyncValue.error(CustomException(CustomExceptionTypes.technicalError.message), StackTrace.empty);
    }
  }

  //Recipe

  void updateTitle(String title){
    state = AsyncData(state.value!.copyWith(name: title));
  }

  void updateDescription(String description){
    state = AsyncData(state.value!.copyWith(description: description));
  }

  void updateCategory(String categoryCode){
    state = AsyncData(state.value!.copyWith(categoryCode: categoryCode));
  }
  //Ingredients
  void addIngredientItem(){
    Ingredients ingredients = Ingredients(name: '', count: '', unit: '', idRecipe: 0);
    var currentIngredients = state.value!.ingredients;
    state = AsyncData(state.value!.copyWith(ingredients: [...currentIngredients, ingredients]));
  }

  void deleteIngredientItem(int index){
    List<Ingredients> newIngredients = state.value!.ingredients;
    newIngredients.removeAt(index);
    state = AsyncData(state.value!.copyWith(ingredients:newIngredients));
  }

  void updateIngredientItem(int index,
      Ingredients updatedIngredient){
    List<Ingredients> newIngredients = state.value!.ingredients;
    newIngredients[index] = updatedIngredient;
    state = AsyncData(state.value!.copyWith(ingredients:newIngredients));
  }

  //Steps

  void addStepItem(){
    RecipeStep step = RecipeStep(idRecipe: 0, order: 0, description: "");
    var currentSteps = state.value!.steps;
    state = AsyncData(state.value!.copyWith(steps: [...?currentSteps, step]));
  }

  void deleteStepItem(int index){
    List<RecipeStep> newSteps = state.value!.steps!;
    newSteps.removeAt(index);
    state = AsyncData(state.value!.copyWith(steps: newSteps));
  }

  void updateStepOrder(int currentIndex, int newIndex){
    List<RecipeStep> newSteps = state.value!.steps!;
    RecipeStep step = newSteps[currentIndex];
    newSteps.removeAt(currentIndex);
    newSteps.insert(newIndex, step);

    state = AsyncData(state.value!.copyWith(steps: newSteps));
  }

  void updateStepItem(int index,
      RecipeStep updatedStep){
    List<RecipeStep> newSteps = state.value!.steps!;
    newSteps[index] = updatedStep;
    state = AsyncData(state.value!.copyWith(steps:newSteps));
  }

  //Tags
  void addTagItem(Tag tag) async {
    var currentTags = state.value!.tags;
    state = AsyncData(state.value!.copyWith(tags: [...?currentTags, tag]));
  }

  void deleteTagItem(int index){
    List<Tag> newTags = state.value!.tags!;
    newTags.removeAt(index);
    state = AsyncData(state.value!.copyWith(tags: newTags));
  }

  void pickImage() async {
    final photosPermissionStatus = await Permission.photos.request();
    if(photosPermissionStatus.isGranted){
      final XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        state = AsyncData(state.value!.copyWith(imagePath: pickedFile.path));
      }
    }
  }

}

final recipeFormProvider = StateNotifierProvider<RecipeFormNotifier, AsyncValue<Recipe>>((ref) {
  final getRecipebyIdUsecase = ref.read(getRecipeByIdUsecaseProvider);
  final saveRecipeUsecase = ref.read(saveRecipeUsecaseProvider);
  return RecipeFormNotifier(getRecipeByIdUsecase: getRecipebyIdUsecase, saveRecipeUsecase: saveRecipeUsecase);
});