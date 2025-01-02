import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/screens/RecipeDetailScreen.dart';
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeFormScreen()));
      },
        child: const Icon(Icons.add),
      ),
      body: itemListState.when(
          data: (itemList){
            return BodyRecipeList(itemList, (idRecipe){
              Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailScreen(idRecipe: idRecipe,)));
            });
          },
          error: (e, s){return CustomErrorWidget(message: e.toString());},
          loading: (){return LoadingWidget();})
    );
  }

  Widget BodyRecipeList (List<Recipe> recipeList, Function(int) onClick){
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
        ),
        itemCount: recipeList?.length,
        itemBuilder: (context, index){
          Recipe recipe = recipeList[index];
          return GestureDetector(
            child: RecipeCardWidget(recipe : recipe),
            onTap: (){onClick(recipe.id!);},
          );
        });
  }
  
}