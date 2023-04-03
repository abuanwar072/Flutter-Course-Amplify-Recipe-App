import 'package:amplify_recipe/features/details/modle/ingredient.dart';
import 'package:amplify_recipe/shared/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/gaps.dart';
import 'ingredient_tile.dart';

class Ingredients extends StatelessWidget {
  const Ingredients({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapH24,
        Text("Ingredients (8)", style: Theme.of(context).textTheme.titleLarge),
        ...List.generate(
          demoIngredients.length,
          (index) => Padding(
            padding: const EdgeInsets.only(top: defaultPadding),
            child: IngredientTile(
              name: demoIngredients[index].name,
              quantity: demoIngredients[index].measure,
            ),
          ),
        ),
      ],
    );
  }
}
