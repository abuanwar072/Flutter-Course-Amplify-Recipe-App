// ignore_for_file: unused_import

import 'package:amplify_recipe/shared/data/model/recipe.dart';
import 'package:amplify_recipe/shared/data/recipe_repository.dart';
import 'package:amplify_recipe/features/details/screens/recipe_details_screen.dart';
import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/constants/gaps.dart';
import 'package:amplify_recipe/shared/widgets/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/constants/constants.dart';

class AllRecipesScreen extends StatelessWidget {
  const AllRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeRepository = getIt.get<RecipeRepository>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Recipes 👾',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH8,
              Expanded(
                child: StreamBuilder<List<Recipe>>(
                  stream: recipeRepository.listenRecipes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final recipes = snapshot.data!;
                      return ListView.builder(
                        itemCount: recipes.length,
                        itemBuilder: (context, index) {
                          final recipe = recipes[index];
                          return Padding(
                            padding:
                                const EdgeInsets.only(bottom: defaultPadding),
                            child: RecipeCard(
                              press: () {
                                context.push(
                                  '/recipe/${recipe.id}',
                                );
                              },
                              onBookmarked: () {
                                recipeRepository.toggleFavoriteForRecipe(
                                  id: recipe.id,
                                  isFavorited: !recipe.isFavorited,
                                );
                              },
                              title: recipe.title,
                              image: recipe.image,
                              category: recipe.category,
                              duration: recipe.duration,
                              serve: recipe.serve,
                              isFavorited: recipe.isFavorited,
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          snapshot.error.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
