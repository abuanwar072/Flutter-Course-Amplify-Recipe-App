import 'package:amplify_recipe/shared/constants/constants.dart';
import 'package:amplify_recipe/shared/constants/gaps.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/ingredients.dart';

class RecipeDetailsScreen extends StatelessWidget {
  const RecipeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.bookmark_border,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.5,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: 'https://i.postimg.cc/G3Wv8Qfy/recipe-img.png',
                  fit: BoxFit.cover,
                ),
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
                  Text("Vegetable Pasta",
                      style: Theme.of(context).textTheme.titleLarge),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: defaultPadding / 2, bottom: defaultPadding),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/clock.svg",
                        ),
                        gapW4,
                        const Text("30 min"),
                        gapW16,
                        SvgPicture.asset(
                          "assets/icons/Profile.svg",
                          height: 16,
                          color: const Color(0xFFB1B1B1),
                        ),
                        gapW4,
                        const Text("2 serves"),
                      ],
                    ),
                  ),
                  const Text(
                      "Pasta mixed with fresh vegetables and doused with a delicious sauce with a high taste, this food is rich in nutrients and is very suitable for..."),
                  const Ingredients(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
