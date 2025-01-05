import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/models/TagListState.dart';
import 'package:recipes_project/usecases/GetTagsUseCase.dart';
import 'package:recipes_project/usecases/SaveTagUsecase.dart';

import '../models/Tag.dart';

class TagListNotifier extends StateNotifier<TagListState>{
  GetTagsUsecase getTagsUsecase;
  SaveTagUsecase saveTagUsecase;

  TagListNotifier({required this.getTagsUsecase, required this.saveTagUsecase}):super(TagListState(tagList: []));

  void init(){
    getAllTags();
  }

  void getAllTags() async{
    List<Tag> tagList = await getTagsUsecase.call();
    state = TagListState(tagList: tagList);
  }

  Future<Tag> insertTagItem(Tag tag) async{
    int id = await saveTagUsecase.call(tag);
    getAllTags();
    return tag.copyWith(id: id);
  }

}

final tagListProvider = StateNotifierProvider<TagListNotifier, TagListState>((ref) {
  final getTagsUsecase = ref.read(getTagsUsecaseProvider);
  final saveTagUsecase = ref.read(saveTagUsecaseProvider);
  return TagListNotifier(getTagsUsecase: getTagsUsecase, saveTagUsecase: saveTagUsecase);
});