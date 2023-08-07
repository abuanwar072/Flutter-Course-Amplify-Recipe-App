import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/data/model/notification.dart';
import 'package:amplify_recipe/shared/data/notification_repository.dart';
import 'package:flutter/material.dart' hide Notification;

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: FutureBuilder<List<Notification>>(
        future: getIt.get<NotificationRepository>().fetchAllNotifications(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                for (final notification in snapshot.data!)
                  ListTile(
                    leading:
                        notification.isSeen ? null : const Icon(Icons.circle),
                    title: Text(notification.title),
                    subtitle: Text(notification.description),
                    onTap: () {
                      getIt
                          .get<NotificationRepository>()
                          .markAsSeen(notification.id);
                    },
                  )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
