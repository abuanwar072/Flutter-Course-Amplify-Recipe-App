import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class SectionListTile extends StatelessWidget {
  const SectionListTile({
    super.key,
    required this.title,
    this.trailingText = 'See all',
    required this.press,
  });

  final String title, trailingText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        TextButton(
          onPressed: press,
          style: TextButton.styleFrom(foregroundColor: AppColors.bodyText),
          child: Text(trailingText),
        )
      ],
    );
  }
}
