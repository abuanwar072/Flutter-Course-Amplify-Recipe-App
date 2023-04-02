import 'package:amplify_recipe/shared/constants/gaps.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/constants.dart';
import '../../../shared/widgets/recipe_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH24,
              Text(
                "Saved 😍",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              gapH8,
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(top: defaultPadding),
                    child: RecipeCard(
                      press: () {},
                      title: "Beef Ramen",
                      image: "https://i.postimg.cc/wx2wxNRm/Image.png",
                      category: "Soup",
                      isBookmarked: true,
                      duration: 30,
                      serve: 2,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
