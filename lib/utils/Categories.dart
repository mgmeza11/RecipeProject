enum Category{
  breakfast(code: "BREAKFAST", name: "Desayuno"),
  lunch(code: "LUNCH", name: "Almuerzo"),
  snack(code: "SNACK", name: "Merienda"),
  dinner(code: "DINNER", name: "Cena");

  final String code;
  final String name;

  const Category({required this.code, required this.name});
}