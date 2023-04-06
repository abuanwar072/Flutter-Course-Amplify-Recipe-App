import 'package:amplify_recipe/features/favorite/screens/favorite_screen.dart';
import 'package:amplify_recipe/features/home/screens/home_screen.dart';
import 'package:amplify_recipe/features/profile/screens/profile_screen.dart';
import 'package:amplify_recipe/thems/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  int _currentPage = 0;
  final List _pages = [
    const HomeScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];
  final Color _iconColor = const Color(0xffADADAD);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Home.svg",
              color: _iconColor,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Home.svg",
              color: AppColors.primary,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Bookmark.svg",
              color: _iconColor,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Bookmark.svg",
              color: AppColors.primary,
            ),
            label: "Bookmarked",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Profile.svg",
              color: _iconColor,
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Profile.svg",
              color: AppColors.primary,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
