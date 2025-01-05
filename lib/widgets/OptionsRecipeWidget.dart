import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionsRecipeWidget extends StatelessWidget{

  VoidCallback? onEdit;
  VoidCallback? onDelete;

  OptionsRecipeWidget({super.key, this.onDelete, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(onPressed: onEdit,
            icon: const Icon(Icons.edit, color: Colors.blueGrey,),
        ),
        IconButton(onPressed: onDelete,
            icon: const Icon(Icons.delete_outline, color: Colors.red,)
        ),

      ],
    );
  }
}