import 'package:flutter/cupertino.dart';
import 'package:recipes_project/utils/Categories.dart';
import 'package:recipes_project/widgets/OptionsRecipeWidget.dart';

import 'CategoryNameWidget.dart';

class HeaderRecipeWidget extends StatelessWidget{
  final String? imagePath;
  final CategoryType categoryType;
  bool showOptions = false;

  HeaderRecipeWidget({super.key, this.imagePath, required this.categoryType, this.showOptions = false});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/imagen_pasta.jpeg"),
        CategoryNameWidget(category: categoryType),
        if (showOptions) Positioned(
          right: 10,
            child: OptionsRecipeWidget()
        )
      ],
    );
  }
}