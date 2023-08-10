import 'package:amplify_recipe/shared/data/authentication_repository.dart';
import 'package:amplify_recipe/shared/data/notification_repository.dart';
import 'package:amplify_recipe/shared/data/recipe_repository.dart';
import 'package:amplify_recipe/features/recipes/screens/search/screen/add_recipe_screen.dart';
import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/constants/constants.dart';
import 'package:amplify_recipe/shared/constants/gaps.dart';
import 'package:amplify_recipe/shared/widgets/recipe_card.dart';
import 'package:amplify_recipe/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/section_list_tile.dart';
import '../widgets/search_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            useSafeArea: true,
            context: context,
            builder: (context) {
              return const AddRecipeScreen();
            },
          );
        },
        label: const Text('Add Recipe'),
      ),
      appBar: AppBar(
        title: Text('Hello, ${getIt.get<AuthenticationRepository>().name} 👋'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              context.push('/notifications');
            },
            icon: StreamBuilder<bool>(
              stream: getIt
                  .get<NotificationRepository>()
                  .listenUnseenNotifications(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!) {
                  return Badge(
                    smallSize: 8,
                    backgroundColor: AppColors.success,
                    child: SvgPicture.asset(
                      'assets/icons/Notification.svg',
                      colorFilter: const ColorFilter.mode(
                        AppColors.bodyText,
                        BlendMode.srcIn,
                      ),
                    ),
                  );
                } else {
                  return SvgPicture.asset(
                    'assets/icons/Notification.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColors.bodyText,
                      BlendMode.srcIn,
                    ),
                  );
                }
              },
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
                context.push('/all-recipes');
              },
            ),
            gapH16,
            StreamBuilder(
              stream: getIt.get<RecipeRepository>().listenLatestRecipes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final recipes = snapshot.data!;
                  if (recipes.isEmpty) {
                    return Center(
                      child: Text(
                        '\n\n\nYou don\'t have any recipes (yet).\n\nAdd them by clicking the "Add Recipe" button below.',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
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
                                context.push(
                                  '/recipe/${recipe.id}',
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
                              onDismissed: (_) {
                                getIt
                                    .get<RecipeRepository>()
                                    .deleteRecipe(recipe.id);
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
