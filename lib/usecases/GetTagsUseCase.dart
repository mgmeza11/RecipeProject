import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Tag.dart';
import '../repository/TagRepository.dart';

class GetTagsUsecase {

  TagRepository tagsRepository;

  GetTagsUsecase({required this.tagsRepository});

  Future<List<Tag>> call() async {
    return tagsRepository.getAll();
  }
}

final getTagsUsecaseProvider = Provider<GetTagsUsecase>((ref) {
  final tagsRepository = ref.read(tagRepositoryProvider);
  return GetTagsUsecase(tagsRepository: tagsRepository);
});