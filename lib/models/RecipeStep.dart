class RecipeStep{
  int? id;
  int idRecipe;
  String description;
  int order;

  RecipeStep({
    this.id,
    required this.idRecipe,
    required this.description,
    required this.order
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'id_recipe': idRecipe,
      'description': description,
      'order' : order
    };
  }

  static RecipeStep fromMap(Map<String, dynamic> map){
    return RecipeStep(
        id: map['id'],
        description: map['description'],
        order: map['order'],
        idRecipe: map['id_recipe']
    );
  }
}