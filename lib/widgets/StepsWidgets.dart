import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_project/models/RecipeStep.dart';

Widget StepRow(
    {
      required RecipeStep step,
      required int index,
      required int maxIndex,
      required Function(RecipeStep) onChanged,
      required VoidCallback onUpSelected,
      required VoidCallback onDownSelected,
      required VoidCallback onDelete}){
  bool isUpButtonEnabled = index < maxIndex;
  bool isDownButtonEnabled = index > 0;
  return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: TextFormField(
          onChanged: (value){
            RecipeStep newStep = step.copyWith(description: value);
            onChanged(newStep);
          },
          controller: TextEditingController(text: step.description),
        )
        ),
        IconButton(onPressed: isDownButtonEnabled ? onDownSelected : null, icon: Icon(Icons.arrow_upward, color: (isDownButtonEnabled ? Colors.blue: Colors.grey.withOpacity(0.5)),)),
        IconButton(onPressed: isUpButtonEnabled ? onUpSelected : null, icon: Icon(Icons.arrow_downward, color: (isUpButtonEnabled ? Colors.blue: Colors.grey.withOpacity(0.5)))),
        IconButton(onPressed: onDelete, icon: const Icon(Icons.delete_outline, color: Colors.red,)),

      ]
  );

}