import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/constants/constants.dart';
import '../../../shared/constants/gaps.dart';

class SocalLoginBtns extends StatelessWidget {
  const SocalLoginBtns({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 1.5),
              child: Text("or continue with"),
            ),
            Expanded(
              child: Divider(),
            ),
          ],
        ),
        gapH16,
        OutlinedButton.icon(
          onPressed: () {},
          icon: SvgPicture.asset("assets/icons/Google.svg"),
          label: const Text("Sign Up with Google"),
        ),
        gapH16,
        OutlinedButton.icon(
          onPressed: () {},
          icon: SvgPicture.asset("assets/icons/Faceboook.svg"),
          label: const Text("Sign Up with Facebook"),
        ),
      ],
    );
  }
}
