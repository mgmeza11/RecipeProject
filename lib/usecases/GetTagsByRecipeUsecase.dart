import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Tag.dart';
import '../repository/TagRepository.dart';

class GetTagsByRecipeUsecase {

  TagRepository tagsRepository;

  GetTagsByRecipeUsecase({required this.tagsRepository});

  Future<List<Tag>> call(int idRecipe) async {
    return await tagsRepository.getByRecipe(idRecipe);
  }
}

final getTagsByRecipeUsecaseProvider = Provider<GetTagsByRecipeUsecase>((ref) {
  final tagsRepository = ref.read(tagRepositoryProvider);
  return GetTagsByRecipeUsecase(tagsRepository: tagsRepository);
});