import 'package:flutter/cupertino.dart';
import 'package:recipes_project/models/Ingredients.dart';

class IngredientWidget extends StatelessWidget{
  final Ingredients ingredient;

  const IngredientWidget({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${ingredient.count.toString()} ${ingredient.unit} '),
        Text(ingredient.name)
      ],
    );
  }
}