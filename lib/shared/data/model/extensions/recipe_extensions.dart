import 'package:amplify_recipe/shared/data/model/recipe.dart' as local;
import 'package:amplify_recipe/models/Category.dart';
import 'package:amplify_recipe/models/Duration.dart';
import 'package:amplify_recipe/models/Recipe.dart' as remote;

extension RecipeExtensions on local.Recipe {
  remote.Recipe toRemoteRecipe() {
    final localDuration = toRemoteDuration();
    return remote.Recipe(
      id: id,
      title: title,
      description: description,
      serve: serve,
      duration: localDuration.duration,
      duration_unit: localDuration.durationUnit,
      category: toRemoteCategoryEnum(category),
      image: image,
      ingredients: ingredients,
    );
  }

  ({Duration duration, int durationUnit}) toRemoteDuration() {
    final durations = duration.split(' ');
    return (
      duration: toRemoteDurationEnum(durations[1]),
      durationUnit: int.parse(
        durations[0].trim(),
      ),
    );
  }

  Duration toRemoteDurationEnum(String durationText) {
    return switch (durationText.toLowerCase()) {
      'minute' => Duration.MINUTE,
      'hour' => Duration.HOUR,
      _ => throw Exception('Unknown duration type')
    };
  }

  Category toRemoteCategoryEnum(String categoryText) {
    return switch (categoryText.trim()) {
      'Appetizer' => Category.APPETIZER,
      'Dessert' => Category.DESSERT,
      'Fish' => Category.FISH,
      'Main course' => Category.MAIN_COURSE,
      'Salad' => Category.SALAD,
      'Soup' => Category.SOUP,
      _ => throw Exception('Unknown category type')
    };
  }
}
