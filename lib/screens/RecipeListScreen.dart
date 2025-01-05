import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/screens/RecipeDetailScreen.dart';
import 'package:recipes_project/screens/RecipeFiltersScreen.dart';
import 'package:recipes_project/utils/CustomException.dart';
import 'package:recipes_project/utils/FilterUtils.dart';
import 'package:recipes_project/widgets/ErrorWidget.dart';
import 'package:recipes_project/widgets/LoadingWidget.dart';
import 'package:recipes_project/widgets/RecipeCardWidget.dart';
import '../models/Recipe.dart';
import '../providers/RecipeListProvider.dart';
import 'RecipeFormScreen.dart';

class RecipeListScreen extends ConsumerStatefulWidget {
  const RecipeListScreen({super.key});

  @override
  ConsumerState<RecipeListScreen> createState() => RecipeListScreenState();
}

class RecipeListScreenState extends ConsumerState<RecipeListScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(recipeListProvider.notifier).getAll();
  }

  @override
  Widget build(BuildContext context) {
    final itemListState = ref.watch(recipeListProvider);
    final notifier = ref.read(recipeListProvider.notifier);
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(child: TextField(onChanged: (value){ref.read(recipeListProvider.notifier).updateKeyword(value);},)),
              IconButton(
                  onPressed: () {
                    showFilterBottomSheet(itemListState.value?.currentFilters ?? [], (filters){
                      notifier.updateFilters(filters);
                    });
                  },
                  icon: const Icon(Icons.filter_alt_outlined)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RecipeFormScreen()));
          },
          child: const Icon(Icons.add),
        ),
        body: itemListState.when(data: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerFilterTags(state.currentFilters, (index) => {
                ref.read(recipeListProvider.notifier).deleteFilter(index)
              }),
              Expanded(
                  child: (state.listRecipe.isNotEmpty)? BodyRecipeList(state.listRecipe, (idRecipe) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecipeDetailScreen(
                              idRecipe: idRecipe,
                            )));
              }) : CustomErrorWidget(message: CustomExceptionTypes.noResult.message)
              )
            ],
          );
        }, error: (e, s) {
          return CustomErrorWidget(message: e.toString());
        }, loading: () {
          return LoadingWidget();
        }));
  }

  Widget BodyRecipeList(List<Recipe> recipeList, Function(int) onClick) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
        ),
        itemCount: recipeList?.length,
        itemBuilder: (context, index) {
          Recipe recipe = recipeList[index];
          return GestureDetector(
            child: RecipeCardWidget(recipe: recipe),
            onTap: () {
              onClick(recipe.id!);
            },
          );
        });
  }

  Widget ContainerFilterTags(List<dynamic> tagList, Function(int) onDelete) {
    return Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Wrap(
          spacing: 5,
          children: tagList
              .asMap()
              .entries
              .map((e) =>
                  FilterTag(filter: e.value, index: e.key, onDelete: onDelete))
              .toList(),
        ));
  }

  Widget FilterTag(
      {dynamic filter, required int index, required Function(int) onDelete}) {
    String filterLabel = getFilterLabel(filter);
    return Chip(
      label: Text(filterLabel),
      deleteIcon: const Icon(Icons.close),
      onDeleted: () {
        onDelete(index);
      },
      backgroundColor: Colors.cyanAccent.withOpacity(0.1),
      side: BorderSide.none,
    );
  }

  void showFilterBottomSheet(List<dynamic> filterList, Function(List<dynamic>) callBack) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return RecipeFiltersScreen(
            currentFilters: filterList,
            callBack: callBack,
          );
        });
  }

  void showSnackbar(String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
