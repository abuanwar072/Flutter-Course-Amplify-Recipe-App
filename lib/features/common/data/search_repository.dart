import 'package:amplify_recipe/features/common/data/model/search_item.dart';

abstract class SearchRepository {
  Stream<List<SearchItem>> listenSearchItems();

  Future<void> deleteAllSearchItems();

  Future<void> saveSearchItem(String searchItem);

  Future<void> deleteSearchItemWithId(String id);
}
