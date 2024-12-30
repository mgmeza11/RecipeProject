class Step{
  int? id;
  int idRecipe;
  String description;
  int order;

  Step({
    this.id,
    required this.idRecipe,
    required this.description,
    required this.order
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'idRecipe': idRecipe,
      'description': description,
      'order' : order
    };
  }
}