// ignore_for_file: unused_import

import 'dart:async';

import 'package:amplify_recipe/shared/data/model/recipe.dart';
import 'package:amplify_recipe/shared/data/model/search_item.dart';
import 'package:amplify_recipe/shared/data/recipe_repository.dart';
import 'package:amplify_recipe/features/details/screens/recipe_details_screen.dart';
import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/data/search_repository.dart';
import 'package:amplify_recipe/shared/constants/constants.dart';
import 'package:amplify_recipe/shared/constants/gaps.dart';
import 'package:amplify_recipe/shared/widgets/recipe_card.dart';
import 'package:amplify_recipe/shared/widgets/section_list_tile.dart';
import 'package:amplify_recipe/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../widgets/recent_search_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Timer? debounce;

  void searchWithThrottle(String keyword) {
    debounce?.cancel();
    debounce = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (keyword.isNotEmpty) {
        getIt.get<SearchRepository>().saveSearchItem(keyword);
      }
      debounce?.cancel();
      setState(() {});
    });
  }

  late final TextEditingController _searchFieldController =
      TextEditingController()
        ..addListener(() {
          searchWithThrottle(_searchFieldController.text);
        });

  @override
  void dispose() {
    super.dispose();
    debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Form(
              child: TextFormField(
                autofocus: true,
                controller: _searchFieldController,
                decoration: InputDecoration(
                  hintText: 'Type to find recipes..',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/icons/Search.svg',
                      colorFilter: const ColorFilter.mode(
                        AppColors.bodyText,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (_searchFieldController.text.isEmpty)
              Column(
                children: [
                  gapH16,
                  SectionListTile(
                    title: 'Recently searched',
                    trailingText: 'Delete all',
                    press: () {
                      getIt.get<SearchRepository>().deleteAllSearchItems();
                    },
                  ),
                  FutureBuilder<List<SearchItem>>(
                    future: getIt.get<SearchRepository>().getSearchItems(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final searchItems = snapshot.data!;
                        if (searchItems.isEmpty) {
                          return const Text('No recent searches');
                        }
                        return Column(
                          children: searchItems
                              .map(
                                (searchItem) => RecentSearchTile(
                                  title: searchItem.searchItem,
                                  onTap: () {
                                    _searchFieldController.text =
                                        searchItem.searchItem;
                                  },
                                  onDeleted: () {
                                    getIt
                                        .get<SearchRepository>()
                                        .deleteSearchItemWithId(searchItem.id);
                                  },
                                ),
                              )
                              .toList(growable: false),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const Text('Loading');
                      }
                    },
                  ),
                ],
              )
            else
              FutureBuilder<List<Recipe>>(
                future: getIt.get<SearchRepository>().searchRecipes(
                      _searchFieldController.text,
                    ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        gapH16,
                        SectionListTile(
                          title: 'Search results',
                          press: () {},
                        ),
                        ...List.generate(
                          snapshot.data!.length,
                          (index) {
                            final recipe = snapshot.data![index];
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
                                  setState(() {});
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
                    return const Text('Something went wrong');
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
