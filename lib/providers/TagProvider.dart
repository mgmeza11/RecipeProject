import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/models/TagListState.dart';

import '../models/Tag.dart';
import '../repository/TagRepository.dart';

class TagListNotifier extends StateNotifier<TagListState>{
  TagRepository tagRepository;

  TagListNotifier({required this.tagRepository}):super(TagListState(tagList: []));

  void init(){
    getAllTags();
  }

  void getAllTags() async{
    List<Tag> tagList = await tagRepository.getAll();
    state = TagListState(tagList: tagList);
  }

  Future<Tag> insertTagItem(Tag tag) async{
    int id = await tagRepository.addTag(tag);
    getAllTags();
    return tag.copyWith(id: id);
  }

}

final tagListProvider = StateNotifierProvider<TagListNotifier, TagListState>((ref) {
  final tagRepository = ref.read(tagRepositoryProvider);
  return TagListNotifier(tagRepository: tagRepository);
});