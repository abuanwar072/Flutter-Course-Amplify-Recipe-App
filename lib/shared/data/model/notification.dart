import 'package:isar/isar.dart';

part 'notification.g.dart';

@collection
class Notification {
  Notification({
    required this.id,
    required this.title,
    required this.description,
    required this.recipeId,
    required this.recipeTitle,
    required this.recipeDescription,
    required this.isSeen,
    this.deepLink,
  });

  @Id()
  final String id;
  final String title;
  final String description;
  final String recipeId;
  final String recipeTitle;
  final String recipeDescription;
  final String? deepLink;
  final bool isSeen;
}
