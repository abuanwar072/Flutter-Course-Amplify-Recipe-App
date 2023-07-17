import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_recipe/features/common/data/extentions/recipe_extentions.dart';
import 'package:amplify_recipe/features/common/data/model/recipe.dart';
import 'package:amplify_recipe/features/common/data/model/user.dart';
import 'package:amplify_recipe/models/Recipe.dart' as remote;
import 'package:amplify_recipe/features/common/data/recipe_repository.dart';
import 'package:realm/realm.dart' hide User;

class AmplifyRecipeRepository extends RecipeRepository {
  late Realm realm;

  AmplifyRecipeRepository() {
    final config = Configuration.local([Recipe.schema, User.schema]);
    Realm.open(config).then(
      (configuredRealm) {
        realm = configuredRealm;
        syncRemoteChanges();
      },
    );
  }

  @override
  Future<void> deleteRecipe(String id) {
    // TODO: implement deleteRecipe
    throw UnimplementedError();
  }

  @override
  Future<Recipe> getRecipe(String id) {
    // TODO: implement getRecipe
    throw UnimplementedError();
  }

  @override
  Stream<List<Recipe>> listenFavoriteRecipes() {
    // TODO: implement listenFavoriteRecipes
    throw UnimplementedError();
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
    return recipes.changes
        .map((event) => event.results.toList(growable: false));
  }

  @override
  Future<List<Recipe>> searchRecipes(String searchText) {
    // TODO: implement searchRecipes
    throw UnimplementedError();
  }

  @override
  Future<void> syncLocalChanges() async {
    final unsyncRecipes = realm.query<Recipe>('isSynced == FALSE');
    if (unsyncRecipes.isNotEmpty) {
      for (final recipe in unsyncRecipes) {
        final remoteRecipe = recipe.toRemoteRecipe();
        final request = ModelMutations.update<remote.Recipe>(remoteRecipe);
        final result = await Amplify.API.mutate(request: request).response;
        if (result.hasErrors) {
          safePrint("Error on syncLocalChanges: ${result.errors}");
        } else {
          realm.write(
            () => recipe.isSynced = true,
          );
        }
      }
    }
  }

  @override
  Future<void> syncRemoteChanges() async {
    final request = ModelQueries.list(remote.Recipe.classType);
    final result = await Amplify.API.query(request: request).response;
    final recipies = result.data?.items
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
    realm.writeAsync(() => realm.addAll(recipies, update: true));
  }

  @override
  Future<void> toggleFavoriteRecipe(
      {required String id, required bool isFavorite}) {
    // TODO: implement toggleFavoriteRecipe
    throw UnimplementedError();
  }
}
