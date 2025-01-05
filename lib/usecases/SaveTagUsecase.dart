import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Tag.dart';
import '../repository/TagRepository.dart';

class SaveTagUsecase {

  TagRepository tagRepository;

  SaveTagUsecase({required this.tagRepository});

  Future<int> call(Tag tag) async {
    return await tagRepository.addTag(tag);
  }
}

final saveTagUsecaseProvider = Provider<SaveTagUsecase>((ref) {
  final tagRepository = ref.read(tagRepositoryProvider);
  return SaveTagUsecase(tagRepository: tagRepository);
});