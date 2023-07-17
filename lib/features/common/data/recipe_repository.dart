import 'package:amplify_recipe/features/common/data/model/recipe.dart';

abstract class RecipeRepository {
  Future<void> toggleFavoriteRecipe(
      {required String id, required bool isFavorite});

  Future<void> deleteRecipe(String id);

  Future<Recipe> getRecipe(String id);

  Stream<List<Recipe>> listenRecipes();

  Stream<List<Recipe>> listenLatestRecipes();

  Stream<List<Recipe>> listenFavoriteRecipes();

  Future<List<Recipe>> searchRecipes(String searchText);

  Future<void> syncLocalChanges();

  Future<void> syncRemoteChanges();
}
