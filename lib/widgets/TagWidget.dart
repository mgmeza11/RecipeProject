import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/models/Tag.dart';
import 'package:recipes_project/providers/TagProvider.dart';
import 'package:recipes_project/widgets/ButtonWidgets.dart';


Widget TagWidget({required Tag tag, required int index, required Function(int) onDelete}) {
  return Chip(label: Text(tag.description),
    deleteIcon: const Icon(Icons.close),
    onDeleted: () {onDelete(index);},
    backgroundColor: Colors.cyanAccent.withOpacity(0.1),
    side: BorderSide.none,
  );
}

Widget TagLabelWidget({required Tag tag}) {
  return Chip(label: Text(tag.description),
    backgroundColor: Colors.cyanAccent.withOpacity(0.1),
    side: BorderSide.none,
  );
}

class CreateTagWidget extends ConsumerStatefulWidget {
  Function(Tag) onAdd;

  CreateTagWidget({super.key, required this.onAdd});

  @override
  ConsumerState<CreateTagWidget> createState() => CreateTagWidgetState();
}

class CreateTagWidgetState extends ConsumerState<CreateTagWidget>{

  @override
  void initState() {
    super.initState();
    ref.read(tagListProvider.notifier).init();
  }

  @override
  Widget build(BuildContext context) {
    var tagListStateProvider = ref.watch(tagListProvider);
    List<Tag> tagList = tagListStateProvider.tagList;
    Tag tag = Tag(description: '');
    return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: Autocomplete<Tag>(
              onSelected: (v){tag = v;},
              displayStringForOption: (tag) => tag.description,
              optionsBuilder: (TextEditingValue textEditingValue) {
                return tagList.where((item) => item.description.toString()
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase())).toList();
              },
              fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                return TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  onChanged: (value) {
                    tag = Tag(description: value);
                  },
                );
              }
          )),
          CustomAddButton(() async {
            Tag newTag = await ref.read(tagListProvider.notifier).insertTagItem(tag);
            widget.onAdd(newTag);
          })
        ]
    );
  }

}


Widget ContainerAddTag(List<Tag> tagList){
  return Container(
    child: TagSelector(onChanged: (val){}, value: '', tagList: tagList),
  );
}

Widget TagSelector({required Function(Tag) onChanged, required String value, required List<Tag> tagList}){
  return Autocomplete<Tag>(
    onSelected: onChanged,
      displayStringForOption: (tag) => tag.description,
      optionsBuilder: (TextEditingValue textEditingValue) {
        return tagList.where((item) => item.description.toString()
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase())).toList();
      }
  );
}