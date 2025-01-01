import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_project/utils/Categories.dart';

class MainIconWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var categoriesList = CategoryType.values;
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      shrinkWrap: true,
      padding: const EdgeInsets.all(30),
      children: List.generate(categoriesList.length, (index) =>
          MainIconItemWidget(category: categoriesList[index])
      ),
    );
  }
  
}

class MainIconItemWidget extends StatelessWidget {
  final CategoryType category;
  const MainIconItemWidget({super.key, required this.category});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Center(
        child: Icon(category.icon, size: 60, color: category.color,)
      ),
    );
  }

}