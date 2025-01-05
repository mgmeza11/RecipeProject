import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/models/FilterState.dart';
import 'package:recipes_project/providers/RecipeFiltersProvider.dart';
import '../utils/FilterUtils.dart';

class RecipeFiltersScreen extends ConsumerStatefulWidget {
  List<dynamic> currentFilters;
  Function(List<dynamic>) callBack;
  RecipeFiltersScreen({super.key, required this.currentFilters, required this.callBack});

  @override
  ConsumerState<RecipeFiltersScreen> createState() =>
      RecipeFiltersScreenState();
}

class RecipeFiltersScreenState extends ConsumerState<RecipeFiltersScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(recipeFilterProvider.notifier).init(widget.currentFilters);
  }

  @override
  Widget build(BuildContext context) {
    final filterListState = ref.watch(recipeFilterProvider);
    List<RecipeFilter> filterStateList = filterListState.totalFilters;
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 20),
      child: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: filterStateList.length,
                  itemBuilder: (context, indexTitle) {
                    return ExpansionTile(
                        title: Text(
                          filterStateList[indexTitle].type.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        children: filterStateList[indexTitle].items.asMap().entries.map((e) {
                          return CheckboxListTile(
                            title: Text(
                              getFilterLabel(e.value.data),
                              style: const TextStyle(color: Colors.black38),
                            ),
                            value: e.value.selected,
                            onChanged: (status) {
                              ref.read(recipeFilterProvider.notifier).updateSelectedStatus(status ?? false, indexTitle, e.key);
                            },
                          );
                        }).toList());
                  })),
          CustomButton(() {
            widget.callBack(ref.read(recipeFilterProvider.notifier).getSelectedFilters());
            Navigator.of(context).pop();
          })
        ],
      ),
    );
  }

  Widget CustomButton(VoidCallback onPressed) {
    return ElevatedButton(
        onPressed: onPressed,
        child: const Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.filter_alt_outlined),
            Text(
              'Aplicar',
              style: TextStyle(fontSize: 16),
            )
          ],
        ));
  }
}
