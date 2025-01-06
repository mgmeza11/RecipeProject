import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recipes_project/providers/RecipeFormProvider.dart';
import 'package:recipes_project/widgets/CategoryNameWidget.dart';
import 'package:recipes_project/widgets/StepsWidgets.dart';

import '../models/Ingredients.dart';
import '../models/Recipe.dart';
import '../models/RecipeStep.dart';
import '../models/Tag.dart';
import '../utils/Categories.dart';
import '../widgets/ButtonWidgets.dart';
import '../widgets/ErrorWidget.dart';
import '../widgets/HeaderRecipeFormWidget.dart';
import '../widgets/IngredientsWidget.dart';
import '../widgets/LoadingWidget.dart';
import '../widgets/TagWidget.dart';
import '../widgets/TextInputWidgets.dart';
import '../widgets/TextWidgets.dart';

class RecipeFormScreen extends ConsumerStatefulWidget {
  int? idRecipe;

  RecipeFormScreen({super.key, this.idRecipe});

  @override
  ConsumerState<RecipeFormScreen> createState() => RecipeFormScreenState();
}

class RecipeFormScreenState extends ConsumerState<RecipeFormScreen> {
  List<TextEditingController> controllersStep = [];
  List<List<TextEditingController>> controllersIngredients = [];

  @override
  void initState() {
    super.initState();
    ref.read(recipeFormProvider.notifier).init(widget.idRecipe);
  }

  @override
  Widget build(BuildContext context) {
    var recipeStateProvider = ref.watch(recipeFormProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: recipeStateProvider.when(data: (recipeState) {
        Recipe? recipe = recipeState;
        validateControllers(recipe.ingredients, recipe.steps);

        return SingleChildScrollView(
          child: Column(
            children: [
              HeaderRecipeFormWidget(
                  showOptions: true, imagePath: recipe?.imagePath, pickImage: () async {
                   ref.read(recipeFormProvider.notifier).pickImage();
              },),
              BodyRecipeFormWidget(recipeState, recipeState.ingredients,
                  recipeState.steps, recipe.tags, controllersStep, controllersIngredients)
            ],
          ),
        );
      }, error: (e, s) {
        return CustomErrorWidget(message: e.toString());
      }, loading: () {
        return LoadingWidget();
      })),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ref.read(recipeFormProvider.notifier).saveData();
          Navigator.pop(context, true);
        },
        child: const Icon(Icons.save_outlined),
      ),
    );
  }

  Widget BodyRecipeFormWidget(
      Recipe? recipe,
      List<Ingredients> ingredients,
      List<RecipeStep> steps,
      List<Tag> currentTags,
      List<TextEditingController> controllersStep,
      List<List<TextEditingController>> controllersIngredients) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextInput(recipe?.name, 'Título*', (value) {
              ref.read(recipeFormProvider.notifier).updateTitle(value);
            }),
            const SizedBox(
              height: 5,
            ),
            CustomTextInput(recipe?.description, 'Descripción*', (value) {
              ref.read(recipeFormProvider.notifier).updateDescription(value);
            }),
            const SizedBox(
              height: 10,
            ),
            CategorySelector(
                value: recipe?.categoryCode ?? CategoryType.breakfast.code,
                onChanged: (value) {
                  ref.read(recipeFormProvider.notifier).updateCategory(value);
                }),
            const SizedBox(
              height: 25,
            ),
            const MediumTitle(text: "Ingredientes"),
            if (ingredients.isNotEmpty) IngredientTitle(),
            for (int index = 0; index < ingredients.length; index++)
              IngredientRow(
                  ingredient: ingredients[index],
                  onDelete: () {
                    ref
                        .read(recipeFormProvider.notifier)
                        .deleteIngredientItem(index);
                  },
                  onChangedCount: (value) {
                    ref
                        .read(recipeFormProvider.notifier)
                        .updateIngredientItem(index, value);
                  },
                  onChangedName: (value) {
                    ref
                        .read(recipeFormProvider.notifier)
                        .updateIngredientItem(index, value);
                  },
                  onChangedUnit: (value) {
                    print(index);
                    ref
                        .read(recipeFormProvider.notifier)
                        .updateIngredientItem(index, value);
                  },
                  textEditingControllerList: controllersIngredients[index]
                  ),
            const SizedBox(height: 10),
            CustomAddButton(() {
              ref.read(recipeFormProvider.notifier).addIngredientItem();
            }),
            const SizedBox(
              height: 25,
            ),
            const MediumTitle(text: "Pasos"),
            for (int index = 0; index < steps.length; index++)
              StepRow(
                  step: steps[index],
                  index: index,
                  maxIndex: steps.length - 1,
                  onChanged: (value) {
                    ref
                        .read(recipeFormProvider.notifier)
                        .updateStepItem(index, value);
                  },
                  onUpSelected: () {
                    ref
                        .read(recipeFormProvider.notifier)
                        .updateStepOrder(index, index + 1);
                  },
                  onDownSelected: () {
                    ref
                        .read(recipeFormProvider.notifier)
                        .updateStepOrder(index, index - 1);
                  },
                  onDelete: () {
                    ref.read(recipeFormProvider.notifier).deleteStepItem(index);
                  },
                  textEditingController: controllersStep[index]),
            const SizedBox(height: 5),
            CustomAddButton(() {
              ref.read(recipeFormProvider.notifier).addStepItem();
            }),
            const SizedBox(
              height: 25,
            ),
            const MediumTitle(text: "Etiquetas"),
            CreateTagWidget(
              onAdd: (tag) {
                ref.read(recipeFormProvider.notifier).addTagItem(tag);
              },
            ),
            const SizedBox(
              height: 5,
            ),
            ContainerTags(currentTags, (index) {
              ref.read(recipeFormProvider.notifier).deleteTagItem(index);
            }),
            const SizedBox(
              height: 25,
            )
          ]),
    );
  }

  Widget CategorySelector(
      {required Function(String) onChanged, required String value}) {
    List<CategoryType> categoryTypes = CategoryType.values;
    return DropdownButton(
      value: value,
      hint: const Text("Categoría"),
      items: categoryTypes.map((e) {
        return DropdownMenuItem(
          value: e.code,
          child: CategoryNameWidget(
            category: e,
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
    );
  }

  Widget ContainerTags(List<Tag> tagList, Function(int) onDelete) {
    return Wrap(
      spacing: 5,
      children: tagList
          .asMap()
          .entries
          .map((e) => TagWidget(tag: e.value, index: e.key, onDelete: onDelete))
          .toList(),
    );
  }

  void validateControllers(
      List<Ingredients> ingredients,
      List<RecipeStep> steps,){
      controllersStep = List.generate(
          steps.length,
              (index) =>
              TextEditingController(text: steps[index].description));
    if(ingredients.length != controllersIngredients.length){
      controllersIngredients = List.generate(
          ingredients.length,
              (index) =>
          [
            TextEditingController(text: ingredients[index].count),
            TextEditingController(text: ingredients[index].unit),
            TextEditingController(text: ingredients[index].name),
          ]
      );
    }
  }

  Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }
}
