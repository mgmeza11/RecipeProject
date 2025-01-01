import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/widgets/RecipeCardWidget.dart';

import '../models/Recipe.dart';

class RecipeListScreen extends ConsumerWidget {
  var itemList = [
    Recipe(name: 'Pasta Bolognesa', categoryCode: 'DINNER', description: 'Pasta con carne molida', imagePath: "assets/imagen_pasta.jpeg" ),
    Recipe(name: 'Sandwich de atún', categoryCode: 'SNACK', description: 'Sandwich alto en proteina', imagePath: "assets/imagen_pasta.jpeg"),
    Recipe(name: 'Ensalada César', categoryCode: 'DINNER', description: 'Ensalada con pollo', imagePath: "assets/imagen_pasta.jpeg"),
    Recipe(name: 'Pancakes de avena', categoryCode: 'BREAKFAST', description: 'Pancakes alto en fibra', imagePath: "assets/imagen_pasta.jpeg")
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 3.0,
            mainAxisSpacing: 3.0,
          ),
          itemCount: itemList.length,
          itemBuilder: (context, index){
            return RecipeCardWidget(recipe : itemList[index]);
          }),
    );
  }
  
}