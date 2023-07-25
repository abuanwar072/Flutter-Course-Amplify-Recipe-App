import 'package:amplify_recipe/shared/data/authentication_repository.dart';
import 'package:amplify_recipe/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/constants.dart';
import '../../../shared/constants/gaps.dart';
import '../../../themes/app_colors.dart';

class Settings extends StatelessWidget {
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        gapH8,
        Container(
          color: const Color(0xFF757575).withOpacity(0.08),
          child: const ListTile(
            title: Text('Settings'),
          ),
        ),
        gapH16,
        SettingListTile(
          onTap: () {},
          title: 'Notifications',
          iconSrc: 'assets/icons/Notification.svg',
        ),
        SettingListTile(
          onTap: () {},
          title: 'Language',
          trailingText: 'English',
          iconSrc: 'assets/icons/Language.svg',
        ),
        SettingListTile(
          onTap: () {},
          title: 'Theme',
          trailingText: 'Light',
          iconSrc: 'assets/icons/Moon.svg',
        ),
        SettingListTile(
          onTap: () {},
          title: 'Help',
          iconSrc: 'assets/icons/Help.svg',
        ),
        gapH8,
        SettingListTile(
          onTap: () {
            getIt.get<AuthenticationRepository>().signOut().then((value) {
              context.go('/');
            });
          },
          title: 'Log out',
          isLogout: true,
          iconSrc: 'assets/icons/Logout.svg',
        ),
      ],
    );
  }
}

class SettingListTile extends StatelessWidget {
  const SettingListTile({
    super.key,
    required this.title,
    required this.iconSrc,
    this.trailingText,
    this.isLogout = false,
    required this.onTap,
  });

  final String title, iconSrc;
  final String? trailingText;
  final bool isLogout;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding / 2),
      child: ListTile(
        onTap: onTap,
        minLeadingWidth: 20,
        leading: SvgPicture.asset(
          iconSrc,
          colorFilter: ColorFilter.mode(
              isLogout ? AppColors.error : Colors.grey.shade500,
              BlendMode.srcIn),
          height: 24,
          width: 24,
        ),
        title: Text(
          title,
          style: TextStyle(color: isLogout ? AppColors.error : null),
        ),
        trailing: isLogout
            ? const SizedBox()
            : SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    trailingText != null
                        ? Text(trailingText!)
                        : const SizedBox(),
                    gapW4,
                    const Icon(CupertinoIcons.forward),
                  ],
                ),
              ),
      ),
    );
  }
}
