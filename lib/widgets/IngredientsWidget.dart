import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_project/models/Ingredients.dart';

Widget IngredientWidget(Ingredients ingredient){
  return Padding(padding: const EdgeInsets.only(top: 5), child: Row(
    children: [
      SizedBox(width: 50, child: Text(ingredient.count)),
      const SizedBox(width: 10,),
      SizedBox(width: 50, child: Text(ingredient.unit)),
      const SizedBox(width: 10,),
      Text(ingredient.name)
    ],
  ));
}

Widget IngredientRow(
    {required Ingredients ingredient,
    required Function(Ingredients) onChangedCount,
    required Function(Ingredients) onChangedUnit,
    required Function(Ingredients) onChangedName,
    required VoidCallback onDelete,
      required List<TextEditingController> textEditingControllerList}){
  return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 50, child: TextFormField(
          onChanged: (newCount){
            Ingredients newIngredient = ingredient.copyWith(count: newCount);
            onChangedUnit(newIngredient);
          },
          controller: textEditingControllerList[0],
        ),),
        const SizedBox(width: 10,),
        SizedBox(width: 50, child: TextFormField(
          controller: textEditingControllerList[1],
          onChanged: (newUnit){
            Ingredients newIngredient = ingredient.copyWith(unit: newUnit);
            onChangedUnit(newIngredient);
          },
        ),
        ),
        const SizedBox(width: 10,),
        Expanded(child: TextField(
          controller: textEditingControllerList[2],
          onChanged: (newName){
            Ingredients newIngredient = ingredient.copyWith(name: newName);
            onChangedName(newIngredient);
          },
        )
        ),
        IconButton(onPressed: onDelete, icon: const Icon(Icons.delete_outline, color: Colors.red,))
      ]
  );
}

Widget IngredientTitle(){
  return const Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(width: 50, child: Text('Cant.'),),
        SizedBox(width: 10,),
        SizedBox(width: 50, child: Text('Und'),),
        SizedBox(width: 10,),
        Expanded(child: Text('Ingrediente')
        )
      ]
  );
}
