abstract class NotificationRepository {
  /// Save notification to the local database
  Future<void> saveNotification(
    String title,
    String description,
    String recipeId,
    String recipeTitle,
    String recipeDescription,
    String? deepLink,
  );

  /// Mark all notifications as seen
  Future<void> markAllAsSeen();

  /// Mark the notification by id as seen
  Future<void> markAsSeen(String id);

  /// Listens to all notifications
  Future<void> listenNotifications();

  /// Checks if there is any unseen notification
  Future<bool> hasUnseenNotification();
}
