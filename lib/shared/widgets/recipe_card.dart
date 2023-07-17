import 'package:flutter/material.dart';

import '../../thems/app_colors.dart';
import '../constants/constants.dart';
import 'froested_glass_container.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.title,
    required this.image,
    required this.category,
    required this.duration,
    this.serve = 1,
    this.isBookmarked = false,
    required this.press,
  });
  final String title, image, category, duration;
  final int serve;
  final bool isBookmarked;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: 200,
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              image,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black54,
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ListTile(
                title: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
                subtitle: Text(
                  "$duration Min  |  $serve Serve",
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: FrostedGlassContainer(
                  child: Icon(
                    Icons.bookmark_border,
                    color: isBookmarked ? AppColors.success : Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              height: 32,
              // width: 72,
              child: FrostedGlassContainer(
                borderRadius: 20,
                child: Center(
                  child: Text(
                    category,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
