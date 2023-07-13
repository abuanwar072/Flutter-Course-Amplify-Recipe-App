import 'package:amplify_recipe/shared/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/gaps.dart';
import 'ingredient_tile.dart';

class Ingredients extends StatelessWidget {
  const Ingredients({
    required this.ingredients,
    super.key,
  });

  final List<String> ingredients;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapH24,
        Text(
          'Ingredients ${ingredients.length}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        ...ingredients.map((ingredient) {
          final ingredientSplit = ingredient.split('-');
          return Padding(
            padding: const EdgeInsets.only(top: defaultPadding),
            child: IngredientTile(
              name: ingredientSplit[1],
              quantity: ingredientSplit[0],
            ),
          );
        })
      ],
    );
  }
}
