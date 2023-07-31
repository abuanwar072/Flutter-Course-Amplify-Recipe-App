import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_recipe/shared/data/model/search_item.dart';
import 'package:amplify_recipe/shared/data/search_repository.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LocalSearchRepository extends SearchRepository {
  late Isar isar;

  LocalSearchRepository() {
    getApplicationDocumentsDirectory().then((dir) {
      isar = Isar.open(
        schemas: [SearchItemSchema],
        directory: dir.path,
      );
    });
  }

  @override
  Future<void> deleteAllSearchItems() async {
    isar.write((isar) => isar.searchItems.clear());
  }

  @override
  Future<void> saveSearchItem(String searchItem) async {
    isar.write((isar) {
      isar.searchItems.put(
        SearchItem(
          id: UUID.getUUID(),
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
    return isar.readAsync(
      (isar) => isar.searchItems
          .where()
          .sortByCreatedAtDesc()
          .findAll(limit: 3)
    );
  }
}
