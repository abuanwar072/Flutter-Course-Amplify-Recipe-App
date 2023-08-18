import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Category;
import 'package:amplify_recipe/models/Recipe.dart' as remote;
import 'dart:core' hide Duration;
import 'package:amplify_recipe/models/Category.dart';
import 'package:amplify_recipe/models/Duration.dart';
import 'package:amplify_recipe/shared/data/database/isar_provider.dart';
import 'package:amplify_recipe/shared/data/model/recipe.dart';
import 'package:amplify_recipe/shared/data/recipe_repository.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

class LocalRemoteRecipeRepository extends RecipeRepository {
  LocalRemoteRecipeRepository() {
    isar = IsarProvider.isar;
  }

  late Isar isar;

  @override
  Future<void> deleteRecipe(String id) async {
    final request = ModelMutations.deleteById(
      remote.Recipe.classType,
      remote.RecipeModelIdentifier(id: id),
    );
    final response = await Amplify.API.mutate(request: request).response;

    if (response.hasErrors) {
      safePrint(response.errors);
      throw const ApiOperationException('Failed to delete recipe');
    }
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
  Future<void> updateRecipe(Recipe recipe) async {
    final remoteRecipe = remote.Recipe(
      id: recipe.id,
      title: recipe.title,
      description: recipe.description,
      serve: recipe.serve,
      duration: toRemoteDurationEnum(recipe.duration),
      duration_unit: toRemoteDurationUnit(recipe.duration),
      category: toRemoteCategoryEnum(recipe.category),
      image: '${recipe.image}.jpg',
      ingredients: recipe.ingredients,
    );

    final request = ModelMutations.update(remoteRecipe);
    final response = await Amplify.API.mutate(request: request).response;

    if (response.hasErrors) {
      safePrint(response.errors);
      throw const ApiOperationException('Failed to update recipe');
    }

    isar.write((isar) {
      isar.recipes.put(recipe);
    });
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
    _syncRemoteChanges();
    _listenRemoteChanges();
    return isar.read<Stream<List<Recipe>>>((isar) {
      return isar.recipes
          .where()
          .sortByCreatedAtDesc()
          .build()
          .watch(fireImmediately: true)
          .take(5);
    });
  }

  void _listenRemoteChanges() {
    final createSubscription =
        ModelSubscriptions.onCreate(remote.Recipe.classType);
    final createStream = Amplify.API.subscribe(createSubscription);
    final updateSubscription =
        ModelSubscriptions.onUpdate(remote.Recipe.classType);
    final updateStream = Amplify.API.subscribe(updateSubscription);
    final deleteSubscription =
        ModelSubscriptions.onDelete(remote.Recipe.classType);
    final deleteStream = Amplify.API.subscribe(deleteSubscription);

    updateStream.listen((event) {
      final remoteRecipe = event.data;
      if (remoteRecipe != null) {
        final recipe = Recipe(
          id: remoteRecipe.id,
          title: remoteRecipe.title,
          description: remoteRecipe.description,
          serve: remoteRecipe.serve,
          duration:
              '${remoteRecipe.duration_unit} ${remoteRecipe.duration.name.toLowerCase()}',
          category: remoteRecipe.category.name
              .replaceFirst('_', ' ')
              .toLowerCase()
              .capitalized,
          image: remoteRecipe.image,
          isFavorited: false,
          createdAt:
              remoteRecipe.createdAt?.getDateTimeInUtc() ?? DateTime.now(),
          isSynced: true,
          ingredients: remoteRecipe.ingredients,
        );
        isar.write((isar) {
          isar.recipes.put(recipe);
        });
      }
    });

    deleteStream.listen((event) {
      final id = event.data?.id;
      if (id != null) {
        isar.write((isar) {
          isar.recipes.delete(id);
        });
      }
    });

    createStream.listen((event) {
      final e = event.data;
      if (e != null) {
        final recipe = Recipe(
          id: e.id,
          title: e.title,
          description: e.description,
          serve: e.serve,
          duration: '${e.duration_unit} ${e.duration.name.toLowerCase()}',
          category:
              e.category.name.replaceFirst('_', ' ').toLowerCase().capitalized,
          image: e.image,
          isFavorited: false,
          createdAt: e.createdAt?.getDateTimeInUtc() ?? DateTime.now(),
          isSynced: true,
          ingredients: e.ingredients,
        );
        isar.write((isar) {
          isar.recipes.put(recipe);
        });
      }
    });
  }

  Future<void> _syncRemoteChanges() async {
    final request = ModelQueries.list(remote.Recipe.classType);
    final result = await Amplify.API.query(request: request).response;
    if (result.hasErrors) {
      safePrint(result.errors);
      throw const ApiOperationException('Failed to fetch recipes');
    }
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
    isar.write((isar) {
      for (final recipe in recipes) {
        if (isar.recipes.get(recipe.id) == null) {
          isar.recipes.put(recipe);
        }
      }
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

    final remoteRecipe = remote.Recipe(
      id: recipe.id,
      title: recipe.title,
      description: recipe.description,
      serve: recipe.serve,
      duration: toRemoteDurationEnum(recipe.duration),
      duration_unit: toRemoteDurationUnit(recipe.duration),
      category: toRemoteCategoryEnum(recipe.category),
      image: recipe.image,
      ingredients: recipe.ingredients,
    );

    final request = ModelMutations.create<remote.Recipe>(
      remoteRecipe,
    );
    final result = await Amplify.API.mutate(request: request).response;

    if (result.hasErrors) {
      safePrint(result.errors);
      throw const ApiOperationException('Failed to create recipe');
    }

    return recipe.id;
  }
}

int toRemoteDurationUnit(String duration) {
  final durations = duration.split(' ');
  return int.parse(durations[0].trim());
}

Duration toRemoteDurationEnum(String duration) {
  final durationEnumText = duration.split(' ')[1];
  return switch (durationEnumText.toLowerCase()) {
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
