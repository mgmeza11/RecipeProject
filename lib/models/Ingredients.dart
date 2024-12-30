class Ingredients{
  int? id;
  String name;
  int count;
  int idRecipe;

  Ingredients({
    this.id,
    required this.name,
    required this.count,
    required this.idRecipe
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'idRecipe': idRecipe,
      'name': name,
      'count': count
    };
  }
}