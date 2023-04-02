import 'package:amplify_recipe/shared/constants/constants.dart';
import 'package:amplify_recipe/shared/constants/gaps.dart';
import 'package:amplify_recipe/shared/widgets/section_list_tile.dart';
import 'package:amplify_recipe/thems/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
                decoration: InputDecoration(
                  hintText: "Type for find recipes..",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      "assets/icons/Search.svg",
                      colorFilter: const ColorFilter.mode(
                        AppColors.bodyText,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                gapH16,
                SectionListTile(
                  title: "Recently search",
                  trailingText: "Delete all",
                  press: () {},
                ),
                ...List.generate(
                  3,
                  (index) => RecentSearchTile(
                    title: "Burger",
                    onDeleted: () {},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RecentSearchTile extends StatelessWidget {
  const RecentSearchTile({
    super.key,
    required this.title,
    required this.onDeleted,
  });

  final String title;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListTile(
        onTap: () {},
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: const TextStyle(color: AppColors.bodyText),
        ),
        trailing: IconButton(
          onPressed: onDeleted,
          icon: SvgPicture.asset(
            "assets/icons/Remove.svg",
            color: AppColors.bodyText,
          ),
        ),
      ),
    );
  }
}
