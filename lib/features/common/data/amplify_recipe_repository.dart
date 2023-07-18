import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_recipe/features/common/data/model/recipe.dart';
import 'package:amplify_recipe/features/common/data/model/user.dart';
import 'package:amplify_recipe/features/common/data/recipe_repository.dart';
import 'package:amplify_recipe/models/Recipe.dart' as remote;
import 'package:realm/realm.dart' hide User;
import 'package:amplify_recipe/features/common/data/model/extensions/recipe_extensions.dart';

class AmplifyRecipeRepository extends RecipeRepository {
  late Realm realm;

  AmplifyRecipeRepository() {
    final config = Configuration.local([Recipe.schema, User.schema]);
    Realm.open(config).then((configuredRealm) {
      realm = configuredRealm;
      syncRemoteChanges();
    });
  }

  @override
  Future<void> deleteRecipe(String id) async {
    final recipe = realm.query<Recipe>('id == "$id"').single;
    realm.delete<Recipe>(recipe);
  }

  @override
  Future<Recipe> getRecipe(String id) async {
    final recipe = realm.query<Recipe>('id == "$id"').single;
    return recipe;
  }

  @override
  Future<List<Recipe>> searchRecipes(String searchText) async {
    final recipes = realm.query<Recipe>(
      'title CONTAINS[c] "$searchText" or description CONTAINS[c] "$searchText"',
    );
    return recipes.toList(growable: false);
  }

  @override
  Stream<List<Recipe>> listenFavoritedRecipes() {
    final recipes = realm.query<Recipe>('isFavorited == TRUE');
    return recipes.changes.map(
      (event) => event.results.toList(growable: false),
    );
  }

  @override
  Stream<List<Recipe>> listenLatestRecipes() {
    final recipes = realm.all<Recipe>();
    return recipes.changes.map(
      (event) => event.results.take(5).toList(growable: false),
    );
  }

  @override
  Stream<List<Recipe>> listenRecipes() {
    final recipes = realm.all<Recipe>();
    return recipes.changes.map(
      (event) => event.results.toList(growable: false),
    );
  }

  @override
  Future<void> toggleFavoriteForRecipe({
    required String id,
    required bool isFavorited,
  }) async {
    final recipe = realm.query<Recipe>('id == "$id"').single;
    realm.write(() {
      recipe.isFavorited = isFavorited;
      recipe.isSynced = false;
    });
    syncLocalChanges();
  }

  @override
  Future<void> syncLocalChanges() async {
    final unsyncedRecipes = realm.query<Recipe>('isSynced == FALSE');
    if (unsyncedRecipes.isNotEmpty) {
      for (final recipe in unsyncedRecipes) {
        final remoteRecipe = recipe.toRemoteRecipe();
        final request = ModelMutations.update<remote.Recipe>(
          remoteRecipe,
        );
        final result = await Amplify.API.mutate(request: request).response;
        if (result.hasErrors) {
          safePrint(result.errors);
        } else {
          realm.write(() {
            recipe.isSynced = true;
          });
        }
      }
    }
  }

  @override
  Future<void> syncRemoteChanges() async {
    final request = ModelQueries.list(remote.Recipe.classType);
    final result = await Amplify.API.query(request: request).response;
    final recipes = result.data?.items
            .where((element) => element != null)
            .cast<remote.Recipe>()
            .map(
              (e) => Recipe(
                e.id,
                e.title,
                e.description,
                e.serve,
                '${e.duration_unit} ${e.duration.name.toLowerCase()}',
                e.category.name
                    .replaceFirst('_', ' ')
                    .toLowerCase()
                    .capitalized,
                e.image,
                e.isFavorited,
                isSynced: true,
                ingredients: e.ingredients,
              ),
            )
            .toList(growable: false) ??
        [];
    realm.writeAsync(() {
      realm.addAll(recipes, update: true);
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
    String imagePath,
    List<(String, String)> ingredients,
  ) async {
    final recipe = Recipe(
      DateTime.now().toIso8601String(),
      title,
      description,
      int.parse(serves),
      '$duration $durationUnit',
      category,
      'https://images.unsplash.com/photo-1550305613-3e2b1300b4f5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2V0dGluZ3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
      false,
      ingredients: ingredients
          .map(
            (e) => '${e.$1} ${e.$2}',
          )
          .toList(growable: false),
    );

    realm.write(() {
      realm.add(recipe);
    });

    syncLocalChanges();
  }
}
