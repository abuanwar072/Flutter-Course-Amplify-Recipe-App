import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/data/model/notification.dart';
import 'package:amplify_recipe/shared/data/notification_repository.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:go_router/go_router.dart';

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
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'You don\'t have any notifications (yet).',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            }
            return ListView(
              children: [
                for (final notification in snapshot.data!)
                  ListTile(
                    title: Text(notification.title),
                    subtitle: Text(notification.description),
                    tileColor: notification.isSeen
                        ? Colors.transparent
                        : Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                    onTap: () {
                      getIt
                          .get<NotificationRepository>()
                          .markAsSeen(notification.id);
                      context.push('/recipe/${notification.recipeId}');
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
