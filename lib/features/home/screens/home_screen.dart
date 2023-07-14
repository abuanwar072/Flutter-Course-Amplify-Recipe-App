import 'package:amplify_recipe/features/all_recipes/screens/all_recipes_screen.dart';
import 'package:amplify_recipe/features/common/data/authentication_repository.dart';
import 'package:amplify_recipe/features/common/data/recipe_repository.dart';
import 'package:amplify_recipe/features/details/screens/recipe_details_screen.dart';
import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/constants/constants.dart';
import 'package:amplify_recipe/shared/constants/gaps.dart';
import 'package:amplify_recipe/shared/widgets/recipe_card.dart';
import 'package:amplify_recipe/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/widgets/section_list_tile.dart';
import '../widgets/search_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: const SizedBox(),
        title: Text('Hello, ${getIt.get<AuthenticationRepository>().name} 👋'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Badge(
              smallSize: 8,
              backgroundColor: AppColors.success,
              child: SvgPicture.asset(
                'assets/icons/Notification.svg',
                colorFilter: const ColorFilter.mode(
                  AppColors.bodyText,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          children: [
            gapH8,
            const SearchContaner(),
            gapH16,
            SectionListTile(
              title: 'Latest Recipes',
              press: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AllRecipesScreen(),
                  ),
                );
              },
            ),
            gapH16,
            StreamBuilder(
              stream: getIt.get<RecipeRepository>().listenLatestRecipes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final recipes = snapshot.data!;
                  return Column(
                    children: [
                      ...List.generate(
                        recipes.length,
                        (index) {
                          final recipe = recipes[index];
                          return Padding(
                            padding:
                                const EdgeInsets.only(bottom: defaultPadding),
                            child: RecipeCard(
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecipeDetailsScreen(
                                      id: recipe.id,
                                    ),
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
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
