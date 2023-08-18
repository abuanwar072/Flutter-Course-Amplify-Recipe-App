import 'dart:io';

import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/constants/gaps.dart';
import 'package:amplify_recipe/shared/data/storage_repository.dart';
import 'package:amplify_recipe/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AsyncImageLoader extends StatefulWidget {
  const AsyncImageLoader({
    required this.keyOrUrl,
    this.onImageChanged,
    super.key,
  });

  final String keyOrUrl;
  final ValueSetter? onImageChanged;

  @override
  State<AsyncImageLoader> createState() => _AsyncImageLoaderState();
}

class _AsyncImageLoaderState extends State<AsyncImageLoader> {
  String? updatedImage;
  final imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (updatedImage != null) {
          showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: const Text('Updated Image'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Do you want to update the image?',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  gapH16,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onImageChanged?.call(updatedImage);
                        context.pop('/entry-point');
                      },
                      child: const Text('Yes'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/entry-point');
                      },
                      child: const Text('No'),
                    ),
                  ),
                ],
              );
            },
          );
        }
        return Future.value(true);
      },
      child: GestureDetector(
        onTap: () async {
          final image = await imagePicker.pickImage(
            source: ImageSource.gallery,
          );
          setState(() {
            updatedImage = image?.path;
          });
        },
        child: updatedImage != null
            ? Image.file(
                File(updatedImage!),
                fit: BoxFit.cover,
              )
            : widget.keyOrUrl.startsWith('http')
                ? Image.network(
                    widget.keyOrUrl,
                    fit: BoxFit.cover,
                  )
                : FutureBuilder<String>(
                    future: getIt
                        .get<StorageRepository>()
                        .generateDownloadUrl(widget.keyOrUrl),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
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
                  ),
      ),
    );
  }
}
