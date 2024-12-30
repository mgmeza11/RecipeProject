import 'package:flutter/material.dart';

enum Category{
  breakfast(code: "BREAKFAST", name: "Desayuno", icon: Icons.coffee_outlined, color: Colors.pinkAccent),
  lunch(code: "LUNCH", name: "Almuerzo", icon: Icons.soup_kitchen_outlined, color: Colors.blueAccent),
  snack(code: "SNACK", name: "Merienda", icon: Icons.cookie_outlined, color: Colors.greenAccent),
  dinner(code: "DINNER", name: "Cena", icon: Icons.dinner_dining_outlined, color: Colors.yellowAccent);

  final String code;
  final String name;
  final IconData icon;
  final Color color;

  const Category({required this.code, required this.name, required this.icon, required this.color});
}