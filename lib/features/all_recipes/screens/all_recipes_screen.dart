import 'package:amplify_recipe/features/common/data/model/recipe.dart';
import 'package:amplify_recipe/features/common/data/recipe_repository.dart';
import 'package:amplify_recipe/features/details/screens/recipe_details_screen.dart';
import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/constants/gaps.dart';
import 'package:amplify_recipe/shared/widgets/recipe_card.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/constants.dart';

class AllRecipesScreen extends StatelessWidget {
  const AllRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  stream: getIt.get<RecipeRepository>().listenRecipes(),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RecipeDetailsScreen(id: recipe.id),
                                  ),
                                );
                              },
                              onBookmarked: () {
                                getIt
                                    .get<RecipeRepository>()
                                    .toggleFavoriteForRecipe(
                                      id: recipe.id,
                                      isFavorited: !recipe.isFavorited,
                                    );
                              },
                              title: recipe.title,
                              image: recipe.image,
                              category: recipe.category,
                              duration: recipe.duration,
                              serve: recipe.serve,
                              isBookmarked: recipe.isFavorited,
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