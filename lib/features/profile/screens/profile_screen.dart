import 'package:amplify_recipe/shared/data/authentication_repository.dart';
import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/settings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF757575).withOpacity(0.08),
            child: const ListTile(
              title: Text('Profile'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: ListTile(
              onTap: () {
                context.push('/edit-profile');
              },
              minLeadingWidth: 60,
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: NetworkImage(
                  getIt
                          .get<AuthenticationRepository>()
                          .currentUser
                          ?.profilePicture ??
                      'https://picsum.photos/200',
                ),
              ),
              title: Text(getIt.get<AuthenticationRepository>().fullName),
              trailing: const Icon(CupertinoIcons.forward),
            ),
          ),
          const Settings()
        ],
      ),
    );
  }
}
