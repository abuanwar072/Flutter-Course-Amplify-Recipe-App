import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/constants/gaps.dart';
import 'package:amplify_recipe/shared/data/storage_repository.dart';
import 'package:amplify_recipe/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AsyncImageLoader extends StatelessWidget {
  const AsyncImageLoader({
    required this.keyOrUrl,
    super.key,
  });

  final String keyOrUrl;

  @override
  Widget build(BuildContext context) {
    return keyOrUrl.startsWith('http')
        ? Image.network(
            keyOrUrl,
            fit: BoxFit.cover,
          )
        : FutureBuilder<String>(
            future:
                getIt.get<StorageRepository>().generateDownloadUrl(keyOrUrl),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Image.network(
                  snapshot.data!,
                  fit: BoxFit.cover,
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.error,
                      ),
                      gapH8,
                      Text(
                        'Error loading image',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.error,
                            ),
                      ),
                    ],
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
  }
}
