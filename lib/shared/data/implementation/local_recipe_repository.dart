import 'package:amplify_recipe/shared/data/database/isar_provider.dart';
import 'package:amplify_recipe/shared/data/model/recipe.dart';
import 'package:amplify_recipe/shared/data/recipe_repository.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

class LocalRecipeRepository extends RecipeRepository {
  LocalRecipeRepository() {
    isar = IsarProvider.isar;
  }

  late Isar isar;

  @override
  Future<void> deleteRecipe(String id) async {
    isar.write((isar) {
      isar.recipes.delete(id);
    });
  }

  @override
  Future<Recipe> getRecipe(String id) async {
    final recipe = isar.recipes.get(id);
    if (recipe == null) {
      throw Exception('Recipe not found');
    }
    return isar.read((isar) => recipe);
  }

  @override
  Stream<List<Recipe>> listenFavoritedRecipes() {
    return isar.read<Stream<List<Recipe>>>((isar) {
      return isar.recipes
          .where()
          .isFavoritedEqualTo(true)
          .build()
          .watch(fireImmediately: true);
    });
  }

  @override
  Stream<List<Recipe>> listenLatestRecipes() {
    return isar.read<Stream<List<Recipe>>>((isar) {
      return isar.recipes
          .where()
          .sortByCreatedAtDesc()
          .build()
          .watch(fireImmediately: true)
          .take(5);
    });
  }

  @override
  Stream<List<Recipe>> listenRecipes() {
    return isar.read<Stream<List<Recipe>>>((isar) {
      return isar.recipes
          .where()
          .sortByCreatedAtDesc()
          .build()
          .watch(fireImmediately: true);
    });
  }

  @override
  Future<void> toggleFavoriteForRecipe({
    required String id,
    required bool isFavorited,
  }) async {
    isar.write(
      (isar) {
        return isar.recipes.update.call(id: id, isFavorited: isFavorited);
      },
    );
  }

  @override
  Future<String> addRecipe(
    String title,
    String description,
    String duration,
    String durationUnit,
    String category,
    String serves,
    String imageKey,
    List<(String, String)> ingredients,
  ) async {
    final recipe = Recipe(
      id: const Uuid().v4(),
      title: title,
      description: description,
      serve: int.parse(serves),
      duration: '$duration $durationUnit',
      category: category,
      image: '$imageKey.jpg',
      isFavorited: false,
      createdAt: DateTime.now(),
      ingredients: ingredients
          .map(
            (e) => '${e.$2} - ${e.$1} ',
          )
          .toList(growable: false),
    );

    isar.write((isar) {
      isar.recipes.put(recipe);
    });

    return recipe.id;
  }

  @override
  Future<void> updateRecipe(Recipe recipe) {
    return isar.writeAsync((isar) {
      isar.recipes.put(recipe);
    });
  }
}
