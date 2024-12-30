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
      'idRecipe': idRecipe,
      'idTag': idTag
    };
  }
}