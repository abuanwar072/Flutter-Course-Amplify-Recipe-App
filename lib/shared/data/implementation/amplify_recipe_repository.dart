import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_recipe/shared/data/model/extensions/recipe_extensions.dart';
import 'package:amplify_recipe/shared/data/model/recipe.dart';
import 'package:amplify_recipe/shared/data/recipe_repository.dart';
import 'package:amplify_recipe/models/Recipe.dart' as remote;
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class AmplifyRecipeRepository extends RecipeRepository {
  late Isar isar;

  AmplifyRecipeRepository() {
    getApplicationDocumentsDirectory().then((dir) {
      isar = Isar.open(
        schemas: [RecipeSchema],
        directory: dir.path,
      );
    });
  }

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
    return recipe;
  }

  @override
  Future<List<Recipe>> searchRecipes(String searchText) async {
    return isar.recipes
        .where()
        .titleContains(searchText, caseSensitive: false)
        .or()
        .descriptionContains(searchText, caseSensitive: false)
        .findAll();
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
  Future<void> syncRemoteChanges() async {
    safePrint('syncRemoteChanges started');
    final request = ModelQueries.list(remote.Recipe.classType);
    final result = await Amplify.API.query(request: request).response;
    safePrint('syncRemoteChanges response came $result');
    final recipes = result.data?.items
            .where((element) => element != null)
            .cast<remote.Recipe>()
            .map(
              (e) => Recipe(
                id: e.id,
                title: e.title,
                description: e.description,
                serve: e.serve,
                duration: '${e.duration_unit} ${e.duration.name.toLowerCase()}',
                category: e.category.name
                    .replaceFirst('_', ' ')
                    .toLowerCase()
                    .capitalized,
                image: e.image,
                isFavorited: false,
                createdAt: e.createdAt?.getDateTimeInUtc() ?? DateTime.now(),
                isSynced: true,
                ingredients: e.ingredients,
              ),
            )
            .toList(growable: false) ??
        [];
    safePrint('syncRemoteChanges local objects created');
    isar.write((isar) {
      for (final recipe in recipes) {
        if (isar.recipes.get(recipe.id) == null) {
          isar.recipes.put(recipe);
        }
      }
    });
  }

  @override
  Future<void> addRecipe(
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
      id: UUID.getUUID(),
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

    final remoteRecipe = recipe.toRemoteRecipe();
    final request = ModelMutations.create<remote.Recipe>(
      remoteRecipe,
    );
    final result = await Amplify.API.mutate(request: request).response;

    if (result.hasErrors) {
      safePrint(result.errors);
    }
  }
}
