import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_project/utils/Categories.dart';
import 'package:recipes_project/widgets/OptionsRecipeWidget.dart';

import 'CategoryNameWidget.dart';

class HeaderRecipeWidget extends StatelessWidget{
  final String? imagePath;
  final String categoryCode;
  final double? height;
  bool showOptions = false;
  VoidCallback? onEdit;
  VoidCallback? onDelete;

  HeaderRecipeWidget({super.key, this.imagePath, required this.categoryCode, this.showOptions = false, this.height, this.onEdit, this.onDelete});
  @override
  Widget build(BuildContext context) {
    var categoryType = getCategoryType(categoryCode);
    return Stack(
      children: [
        SizedBox(width: double.infinity, height: height, child: (imagePath != null && imagePath!.isNotEmpty) ? Image.file(File(imagePath!), fit: BoxFit.fitWidth) : const Icon(Icons.dinner_dining_outlined, color: Colors.grey, size: 70,)),
        CategoryNameWidget(category: categoryType),
        if (showOptions) Positioned(
          right: 10,
            child: OptionsRecipeWidget(onEdit: onEdit, onDelete: onDelete,)
        )
      ],
    );
  }
}