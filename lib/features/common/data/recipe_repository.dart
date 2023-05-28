import 'package:amplify_recipe/features/common/data/model/recipe.dart';

abstract class RecipeRepository {

  Future<void> toggleFavoriteForRecipe({
    required String id,
    required bool isFavorited,
  });

  Future<void> deleteRecipe(String id);

  Future<Recipe> getRecipe(String id);

  Future<List<Recipe>> searchRecipes(String searchText);

  Stream<List<Recipe>> listenRecipes();

  Stream<List<Recipe>> listenLatestRecipes();

  Stream<List<Recipe>> listenFavoritedRecipes();

  Future<void> syncLocalChanges();

  Future<void> syncRemoteChanges();
}
