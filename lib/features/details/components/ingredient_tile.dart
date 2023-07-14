import 'package:flutter/material.dart';

import '../../../shared/constants/constants.dart';
import '../../../themes/app_colors.dart';

class IngredientTile extends StatelessWidget {
  const IngredientTile({
    super.key,
    required this.name,
    required this.quantity,
  });

  final String name, quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.inputfieldBg,
        borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
      ),
      child: ListTile(
        title: Text(name),
        trailing: Text(quantity),
      ),
    );
  }
}
