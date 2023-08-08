import 'package:amplify_recipe/shared/data/model/recipe.dart';
import 'package:amplify_recipe/shared/data/recipe_repository.dart';
import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/constants/constants.dart';
import 'package:amplify_recipe/shared/constants/gaps.dart';
import 'package:amplify_recipe/shared/widgets/async_image_loader.dart';
import 'package:amplify_recipe/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/ingredients.dart';

class RecipeDetailsScreen extends StatelessWidget {
  const RecipeDetailsScreen({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Recipe>(
          future: getIt.get<RecipeRepository>().getRecipe(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final recipe = snapshot.data!;
              return Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  leading: const BackButton(color: Colors.white),
                  backgroundColor: Colors.transparent,
                  actions: [
                    _RecipeFavoriteToggleButton(
                      id: recipe.id,
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AsyncImageLoader(keyOrUrl: recipe.image),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.0, 0.5],
                                colors: [
                                  Colors.black54,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recipe.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: defaultPadding / 2,
                                bottom: defaultPadding,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/clock.svg',
                                  ),
                                  gapW4,
                                  Text(recipe.duration),
                                  gapW16,
                                  SvgPicture.asset(
                                    'assets/icons/Profile.svg',
                                    height: 16,
                                    colorFilter: const ColorFilter.mode(
                                      Color(0xFFB1B1B1),
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  gapW4,
                                  Text('${recipe.serve} serves'),
                                ],
                              ),
                            ),
                            Text(recipe.description),
                            Ingredients(
                              ingredients: recipe.ingredients,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text(snapshot.error.toString()),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Recipe Detail Loading'),
                ),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}

class _RecipeFavoriteToggleButton extends StatefulWidget {
  const _RecipeFavoriteToggleButton({
    required this.id,
  });

  final String id;

  @override
  State<_RecipeFavoriteToggleButton> createState() =>
      __RecipeFavoriteToggleButtonState();
}

class __RecipeFavoriteToggleButtonState
    extends State<_RecipeFavoriteToggleButton> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Recipe>(
      future: getIt.get<RecipeRepository>().getRecipe(widget.id),
      builder: (context, snapshot) {
        final isFavorited = (snapshot.data?.isFavorited ?? false);
        return IconButton(
          onPressed: () {
            getIt.get<RecipeRepository>().toggleFavoriteForRecipe(
                  id: widget.id,
                  isFavorited: !isFavorited,
                );
            setState(() {});
          },
          icon: Icon(
            Icons.bookmark_border,
            color: isFavorited ? AppColors.success : Colors.white,
          ),
        );
      },
    );
  }
}
