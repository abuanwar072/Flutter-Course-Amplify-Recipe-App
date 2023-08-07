import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_recipe/main.dart';
import 'package:amplify_recipe/shared/data/model/notification.dart';
import 'package:amplify_recipe/shared/data/notification_repository.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void _backgroundCallback(PushNotificationMessage notification) {
  safePrint('onNotificationReceivedInBackground: $notification');
  final jsonRaw = notification.data['pinpoint.jsonBody'] as String;
  final jsonBody = json.decode(jsonRaw) as Map<String, dynamic>;

  getIt.get<NotificationRepository>().saveNotification(
        notification.title ?? 'Recipe',
        notification.body ?? 'There is a new description',
        jsonBody['recipeId'] as String,
        jsonBody['recipeTitle'] as String,
        jsonBody['recipeDescription'] as String,
        notification.deeplinkUrl,
      );
}

class PinpointNotificationRepository extends NotificationRepository {
  late Isar isar;

  PinpointNotificationRepository() {
    getApplicationDocumentsDirectory().then((dir) {
      isar = Isar.open(
        schemas: [NotificationSchema],
        directory: dir.path,
      );
    });
  }

  @override
  Future<List<Notification>> fetchAllNotifications() {
    return isar.readAsync((isar) {
      return isar.notifications.where().findAll();
    });
  }

  @override
  Future<bool> hasUnseenNotification() {
    return isar.readAsync((isar) {
      return isar.notifications.where().isSeenEqualTo(false).isNotEmpty();
    });
  }

  @override
  Future<void> listenNotifications() async {
    final permissionStatus =
        await Amplify.Notifications.Push.getPermissionStatus();
    if (permissionStatus != PushNotificationPermissionStatus.granted) {
      return;
    }
    Amplify.Notifications.Push.onTokenReceived.listen((event) {
      safePrint(event);
    });
    Amplify.Notifications.Push.onNotificationReceivedInBackground(
      _backgroundCallback,
    );
    Amplify.Notifications.Push.onNotificationReceivedInForeground.listen(
      (notification) {
        safePrint('onNotificationOpenedInBackground: $notification');
        final jsonRaw = notification.data['pinpoint.jsonBody'] as String;
        final jsonBody = json.decode(jsonRaw) as Map<String, dynamic>;
        saveNotification(
          notification.title ?? 'Recipe',
          notification.body ?? 'There is a new description',
          jsonBody['recipeId'] as String,
          jsonBody['recipeTitle'] as String,
          jsonBody['recipeDescription'] as String,
          notification.deeplinkUrl,
        );
      },
    );
    Amplify.Notifications.Push.onNotificationOpened.listen(
      (notification) {
        safePrint('onNotificationOpened: $notification');
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
          id: UUID.getUUID(),
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
}
