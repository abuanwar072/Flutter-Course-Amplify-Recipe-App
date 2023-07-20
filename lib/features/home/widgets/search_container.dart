import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/constants.dart';
import '../../../shared/constants/gaps.dart';
import '../../../themes/app_colors.dart';

class SearchContaner extends StatelessWidget {
  const SearchContaner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/search-recipes');
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: const BoxDecoration(
          color: AppColors.inputfieldBg,
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        child: Row(
          children: [
            SvgPicture.asset('assets/icons/Search.svg'),
            gapW8,
            const Text('Type to find recipes..'),
          ],
        ),
      ),
    );
  }
}
