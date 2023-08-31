import 'package:amplify_recipe/shared/widgets/async_image_loader.dart';
import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';
import '../constants/constants.dart';
import 'frosted_glass_container.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.title,
    required this.image,
    required this.category,
    required this.duration,
    this.serve = 1,
    this.isFavorited = false,
    required this.press,
    required this.onBookmarked,
    this.onDismissed,
  });

  final String title, image, category, duration;
  final int serve;
  final bool isFavorited;
  final VoidCallback press;
  final VoidCallback onBookmarked;
  final DismissDirectionCallback? onDismissed;

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
        child: Dismissible(
          key: ValueKey(title),
          background: Container(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            color: Theme.of(context).colorScheme.error,
            alignment: Alignment.centerRight,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: onDismissed,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AsyncImageLoader(keyOrUrl: image),
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
                    '$duration  |  $serve Serve',
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: GestureDetector(
                    onTap: onBookmarked,
                    child: FrostedGlassContainer(
                      child: Icon(
                        Icons.bookmark_border,
                        color: isFavorited ? AppColors.success : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                height: 32,
                width: 72,
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
      ),
    );
  }
}
