import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_project/utils/Categories.dart';

class CategoryNameWidget extends StatelessWidget{
  final CategoryType category;

  const CategoryNameWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(category.name),
      avatar: Icon(category.icon, color: category.color,),
      backgroundColor: category.color.withOpacity(0.1),
      side: BorderSide.none,
    );
  }
}