import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_recipe/features/common/data/recipe_repository.dart';
import 'package:amplify_recipe/features/details/screens/recipe_details_screen.dart';
import 'package:amplify_recipe/models/Category.dart' as remote;
import 'package:amplify_recipe/models/Duration.dart';
import 'package:amplify_recipe/shared/constants/constants.dart';
import 'package:amplify_recipe/shared/constants/gaps.dart';
import 'package:amplify_recipe/thems/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../main.dart';
import '../../../shared/widgets/recipe_card.dart';
import '../../../shared/widgets/section_list_tile.dart';
import '../../common/data/authentication_repository.dart';
import '../widgest/search_container.dart';

import 'package:amplify_recipe/models/Recipe.dart' as remote;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void createRecipe() async {
    try {
      final recipe = remote.Recipe(
        title: "Vegetable Pasta",
        serve: 1,
        duration: Duration.HOUR,
        category: remote.Category.SALAD,
        description:
            "Pasta mixed with fresh vegetables and doused with a delicious sauce with a high taste, this food is rich in nutrients and is very suitable for",
        image: "https://i.postimg.cc/Cdfb0gYs/rep-2.png",
        isFavorited: false,
        duration_unit: 1,
        ingredients: ['Pasta', 'Tomato', 'Onion'],
      );

      final request = ModelMutations.create(recipe);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint(response.errors);
    } catch (e) {
      safePrint("Error on create recipe: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: const SizedBox(),
        title: Text("Hello, ${getIt.get<AuthenticationRepository>().name} 👋"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              createRecipe();
            },
            icon: Badge(
              smallSize: 8,
              backgroundColor: AppColors.success,
              child: SvgPicture.asset(
                "assets/icons/Notification.svg",
                color: AppColors.bodyText,
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
              title: "Recipes for you",
              press: () {},
            ),
            gapH16,
            StreamBuilder(
              stream: getIt.get<RecipeRepository>().listenLatestRecipes(),
              builder: (context, snapshot) {
                final recipes = snapshot.data!;
                safePrint(recipes);
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
                                    builder: (context) =>
                                        const RecipeDetailsScreen()),
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
