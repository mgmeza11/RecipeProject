import 'package:flutter/material.dart';

enum CategoryType{
  breakfast(code: "BREAKFAST", name: "Desayuno", icon: Icons.coffee_outlined, color: Colors.pinkAccent),
  lunch(code: "LUNCH", name: "Almuerzo", icon: Icons.soup_kitchen_outlined, color: Colors.lime),
  snack(code: "SNACK", name: "Merienda", icon: Icons.cookie_outlined, color: Colors.cyanAccent),
  dinner(code: "DINNER", name: "Cena", icon: Icons.dinner_dining_outlined, color: Colors.purpleAccent);

  final String code;
  final String name;
  final IconData icon;
  final Color color;

  const CategoryType({required this.code, required this.name, required this.icon, required this.color});
}

CategoryType getCategoryType(String code){
  return CategoryType.values.firstWhere((element) => element.code == code);
}