import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionsRecipeWidget extends StatelessWidget{

  bool isEditSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(onPressed: () {
          isEditSelected = !isEditSelected;
        },
            isSelected: isEditSelected,
            icon: Icon(Icons.edit, color: Colors.blueGrey,),
          selectedIcon: Icon(Icons.save_outlined),
        ),
        if (!isEditSelected) IconButton(onPressed: () {

        },
            icon: Icon(Icons.delete_outline, color: Colors.red,)
        ),

      ],
    );
  }
}