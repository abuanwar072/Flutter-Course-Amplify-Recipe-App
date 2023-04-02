import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../thems/app_colors.dart';

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
