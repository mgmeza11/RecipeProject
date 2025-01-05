import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/repository/TagRepository.dart';

class DeleteTagsByRecipeUsecase {

  TagRepository tagRepository;

  DeleteTagsByRecipeUsecase({required this.tagRepository});

  Future<void> call(int idRecipe) async {
    return tagRepository.deleteByRecipe(idRecipe);
  }
}

final deleteTagsByRecipeUsecaseProvider = Provider<DeleteTagsByRecipeUsecase>((ref) {
  final tagsRepository = ref.read(tagRepositoryProvider);
  return DeleteTagsByRecipeUsecase(tagRepository: tagsRepository);
});