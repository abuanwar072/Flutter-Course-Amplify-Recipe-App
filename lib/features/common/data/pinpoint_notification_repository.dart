import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_recipe/features/common/data/model/notification.dart';
import 'package:amplify_recipe/features/common/data/notification_repository.dart';
import 'package:realm/realm.dart';

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
    Amplify.Notifications.Push.onTokenReceived.listen((event) {
      safePrint(event);
    });
    Amplify.Notifications.Push.onNotificationReceivedInBackground(
      (notification) {
        safePrint('onNotificationReceivedInBackground: $notification');
      },
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
