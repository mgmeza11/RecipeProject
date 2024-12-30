class RecipeTag{
  int? id;
  int idRecipe;
  int idTag;

  RecipeTag({
    this.id,
    required this.idRecipe,
    required this.idTag
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'id_recipe': idRecipe,
      'id_tag': idTag
    };
  }

  static RecipeTag fromMap(Map<String, dynamic> map){
    return RecipeTag(
        id: map['id'],
        idRecipe: map['id_recipe'],
        idTag: map['id_tag']
    );
  }
}