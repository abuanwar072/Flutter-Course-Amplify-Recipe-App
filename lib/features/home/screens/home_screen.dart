import 'package:amplify_recipe/shared/constants/constants.dart';
import 'package:amplify_recipe/shared/constants/gaps.dart';
import 'package:amplify_recipe/thems/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/widgets/recipe_card.dart';
import '../../../shared/widgets/section_list_tile.dart';
import '../widgest/search_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: const SizedBox(),
        title: const Text("Hello, Laura 👋"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
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
            ...List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: defaultPadding),
                child: RecipeCard(
                  press: () {},
                  title: "Beef Ramen",
                  image: "https://i.postimg.cc/wx2wxNRm/Image.png",
                  category: "Soup",
                  duration: 30,
                  serve: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
