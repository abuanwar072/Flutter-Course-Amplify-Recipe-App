import 'package:amplify_recipe/shared/data/model/recipe.dart';

abstract class RecipeRepository {
  Future<void> toggleFavoriteForRecipe({
    required String id,
    required bool isFavorited,
  });

  Future<void> deleteRecipe(String id);

  Future<Recipe> getRecipe(String id);

  Future<void> addRecipe(
    String title,
    String description,
    String duration,
    String durationUnit,
    String category,
    String serves,
    String imageKey,
    List<(String, String)> ingredients,
  );

  Stream<List<Recipe>> listenRecipes();

  Stream<List<Recipe>> listenLatestRecipes();

  Stream<List<Recipe>> listenFavoritedRecipes();
}
