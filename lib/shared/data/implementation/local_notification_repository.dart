import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_recipe/shared/data/database/isar_provider.dart';
import 'package:amplify_recipe/shared/data/model/notification.dart';
import 'package:amplify_recipe/shared/data/notification_repository.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

class LocalNotificationRepository extends NotificationRepository {
  LocalNotificationRepository() {
    isar = IsarProvider.isar;
  }

  late Isar isar;

  @override
  Future<List<Notification>> fetchAllNotifications() {
    return isar.readAsync<List<Notification>>((isar) {
      return isar.notifications.where().findAll();
    });
  }

  @override
  Stream<bool> listenUnseenNotifications() {
    return isar.read<Stream<bool>>((isar) {
      return isar.notifications
          .where()
          .isSeenEqualTo(false)
          .build()
          .watch(fireImmediately: true)
          .map((notifications) => notifications.isNotEmpty);
    });
  }

  @override
  Future<void> listenNotifications() async {
    Amplify.Notifications.Push.onNotificationReceivedInForeground.listen(
      (notification) {
        final pinpointBody = notification.data['pinpoint.jsonBody'] as String?;
        if (pinpointBody != null) {
          final recipeJson = json.decode(pinpointBody);
          final recipeTitle = recipeJson['recipeTitle'] as String;
          final recipeDescription = recipeJson['recipeDescription'] as String;
          final recipeId = recipeJson['recipeId'] as String;
          saveNotification(
            notification.title as String,
            notification.body as String,
            recipeId,
            recipeTitle,
            recipeDescription,
            null,
          );
        }
      },
    );

    Amplify.Notifications.Push.onNotificationOpened.listen(
      (notification) {
        final pinpointBody = notification.data['pinpoint.jsonBody'] as String?;
        if (pinpointBody != null) {
          final recipeJson = json.decode(pinpointBody);
          final recipeTitle = recipeJson['recipeTitle'] as String;
          final recipeDescription = recipeJson['recipeDescription'] as String;
          final recipeId = recipeJson['recipeId'] as String;
          saveNotification(
            notification.title as String,
            notification.body as String,
            recipeId,
            recipeTitle,
            recipeDescription,
            null,
          );
        }
      },
    );
  }

  @override
  Future<void> markAllAsSeen() async {
    isar.write((isar) {
      isar.notifications
          .where()
          .isSeenEqualTo(false)
          .build()
          .findAll()
          .forEach((notification) {
        isar.notifications.update(
          id: notification.id,
          isSeen: true,
        );
      });
    });
  }

  @override
  Future<void> markAsSeen(String id) async {
    isar.write((isar) {
      isar.notifications.update(id: id, isSeen: true);
    });
  }

  @override
  Future<void> saveNotification(
    String title,
    String description,
    String recipeId,
    String recipeTitle,
    String recipeDescription,
    String? deepLink,
  ) async {
    isar.write((isar) {
      isar.notifications.put(
        Notification(
          id: const Uuid().v4(),
          title: title,
          description: description,
          recipeId: recipeId,
          recipeTitle: recipeTitle,
          recipeDescription: recipeDescription,
          deepLink: deepLink,
          isSeen: false,
        ),
      );
    });
  }

  @override
  Future<void> handlePermissions() async {
    final status = await Amplify.Notifications.Push.getPermissionStatus();
    if (status == PushNotificationPermissionStatus.granted) {
      // no further action is required, user has already granted permissions
      return;
    }
    if (status == PushNotificationPermissionStatus.denied) {
      return;
    }
    if (status == PushNotificationPermissionStatus.shouldRequest) {
      // go ahead and request permissions from the user
      await Amplify.Notifications.Push.requestPermissions();
    }
    if (status == PushNotificationPermissionStatus.shouldExplainThenRequest) {
      // then request permissions
      await Amplify.Notifications.Push.requestPermissions();
    }
  }
}
