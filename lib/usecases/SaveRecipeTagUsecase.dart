import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/RecipeTag.dart';
import '../models/Tag.dart';
import '../repository/TagRepository.dart';

class SaveRecipeTagUsecase {

  TagRepository tagRepository;

  SaveRecipeTagUsecase({required this.tagRepository});

  Future<void> call(List<Tag> currentTags, int idRecipe) async {
    if (currentTags.isNotEmpty) {
      List<RecipeTag> recipeTags = currentTags.map((e) => RecipeTag(idRecipe: idRecipe, idTag: e.id!)).toList();
      await tagRepository.addRecipeTagList(recipeTags);
    }
  }
}

final saveRecipeTagUsecaseProvider = Provider<SaveRecipeTagUsecase>((ref) {
  final tagRepository = ref.read(tagRepositoryProvider);
  return SaveRecipeTagUsecase(tagRepository: tagRepository);
});