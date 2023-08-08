import 'package:isar/isar.dart';

part 'recipe.g.dart';

@collection
class Recipe {
  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.serve,
    required this.duration,
    required this.category,
    required this.image,
    required this.isFavorited,
    required this.ingredients,
    required this.createdAt,
    this.isSynced = false,
  });

  @Id()
  final String id;
  final String title;
  final String description;
  final int serve;
  final String duration;
  final String category;
  final String image;
  final bool isFavorited;
  final List<String> ingredients;
  final DateTime createdAt;
  final bool isSynced;
}
