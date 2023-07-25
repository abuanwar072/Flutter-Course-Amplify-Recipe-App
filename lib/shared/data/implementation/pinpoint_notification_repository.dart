import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_recipe/shared/data/model/notification.dart';
import 'package:amplify_recipe/shared/data/notification_repository.dart';
import 'package:realm/realm.dart';

void _backgroundCallback(notification) {
  safePrint('onNotificationReceivedInBackground: $notification');
}

class PinpointNotificationRepository extends NotificationRepository {
  late Realm realm;

  PinpointNotificationRepository() {
    final config = Configuration.local([Notification.schema]);
    Realm.open(config).then((configuredRealm) {
      realm = configuredRealm;
    });
  }

  @override
  Future<bool> hasUnseenNotification() {
    // TODO: implement hasUnseenNotification
    throw UnimplementedError();
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
      },
    );
    Amplify.Notifications.Push.onNotificationOpened.listen(
      (notification) {
        safePrint('onNotificationOpened: $notification');
      },
    );
  }

  @override
  Future<void> markAllAsSeen() {
    // TODO: implement markAllAsSeen
    throw UnimplementedError();
  }

  @override
  Future<void> markAsSeen(String id) {
    // TODO: implement markAsSeen
    throw UnimplementedError();
  }

  @override
  Future<void> saveNotification(
    String title,
    String description,
    String? deepLink,
  ) {
    // TODO: implement saveNotification
    throw UnimplementedError();
  }
}
