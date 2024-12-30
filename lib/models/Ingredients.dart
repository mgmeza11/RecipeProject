class Ingredients{
  int? id;
  String name;
  int count;
  int idRecipe;
  String unit;

  Ingredients({
    this.id,
    required this.name,
    required this.count,
    required this.idRecipe,
    required this.unit
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'id_recipe': idRecipe,
      'name': name,
      'count': count,
      'unit': unit
    };
  }

  static Ingredients fromMap(Map<String, dynamic> map){
    return Ingredients(
        id: map['id'],
        name: map['name'],
        count: map['count'],
        idRecipe: map['id_recipe'],
        unit: map['unit']
    );
  }
}