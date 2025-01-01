import 'package:flutter/cupertino.dart';

import '../models/RecipeStep.dart';
import 'TextWidgets.dart';

class StepWidget extends StatelessWidget {
  RecipeStep step;

  StepWidget({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('- '),
        Expanded(child: DetailText(text: step.description))

      ],
    );
  }

}