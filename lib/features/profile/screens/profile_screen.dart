import 'package:amplify_recipe/features/profile/screens/edit_profile_screen.dart';
import 'package:amplify_recipe/shared/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/settings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF757575).withOpacity(0.08),
            child: const ListTile(
              title: Text("Profile"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
              },
              minLeadingWidth: 60,
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade300,
                backgroundImage:
                    const NetworkImage("https://picsum.photos/200"),
              ),
              title: const Text("John Doe"),
              subtitle: const Text("@lauraharper"),
              trailing: const Icon(CupertinoIcons.forward),
            ),
          ),
          const Settings()
        ],
      ),
    );
  }
}
