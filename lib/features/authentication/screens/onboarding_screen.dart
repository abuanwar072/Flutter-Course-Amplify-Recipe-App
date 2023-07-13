import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/onboard_content.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/onboard_image.png',
            fit: BoxFit.fitHeight,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.35, 1],
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
              ),
            ),
          ),
          const OnboardContent(),
        ],
      ),
    );
  }
}
