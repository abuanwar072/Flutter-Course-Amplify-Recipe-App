import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/constants.dart';

class FrostedGlassContainer extends StatelessWidget {
  const FrostedGlassContainer({
    super.key,
    this.size = const Size(40, 40),
    required this.child,
    this.borderRadius = defaultBorderRadius / 2,
  });

  final Size size;
  final Widget child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}
