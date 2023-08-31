import 'package:amplify_recipe/shared/data/database/isar_provider.dart';
import 'package:amplify_recipe/shared/data/model/recipe.dart';
import 'package:amplify_recipe/shared/data/model/search_item.dart';
import 'package:amplify_recipe/shared/data/search_repository.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

class LocalSearchRepository extends SearchRepository {
  LocalSearchRepository() {
    isar = IsarProvider.isar;
  }

  late Isar isar;

  @override
  Future<void> deleteAllSearchItems() async {
    isar.write((isar) => isar.searchItems.clear());
  }

  @override
  Future<void> saveSearchItem(String searchItem) async {
    isar.write((isar) {
      isar.searchItems.put(
        SearchItem(
          id: const Uuid().v4(),
          searchItem: searchItem,
          createdAt: DateTime.now(),
        ),
      );
    });
  }

  @override
  Future<void> deleteSearchItemWithId(String id) async {
    isar.write((isar) {
      isar.searchItems.delete(id);
    });
  }

  @override
  Future<List<SearchItem>> getSearchItems() {
    return isar.readAsync((isar) =>
        isar.searchItems.where().sortByCreatedAtDesc().findAll(limit: 3));
  }

  @override
  Future<List<Recipe>> searchRecipes(String searchTerm) async {
    return isar.recipes
        .where()
        .titleContains(searchTerm, caseSensitive: false)
        .or()
        .descriptionContains(searchTerm, caseSensitive: false)
        .findAll();
  }
}
