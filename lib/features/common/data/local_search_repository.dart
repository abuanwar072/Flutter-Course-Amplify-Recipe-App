import 'package:amplify_recipe/features/common/data/model/search_item.dart';
import 'package:amplify_recipe/features/common/data/search_repository.dart';
import 'package:realm/realm.dart';

class LocalSearchRepository extends SearchRepository {
  late Realm realm;

  LocalSearchRepository() {
    final config = Configuration.local([SearchItem.schema]);
    Realm.open(config).then((configuredRealm) {
      realm = configuredRealm;
    });
  }

  @override
  Future<void> deleteAllSearchItems() async {
    realm.write(() {
      realm.deleteAll<SearchItem>();
    });
  }

  @override
  Future<void> saveSearchItem(String searchItem) async {
    realm.write(() {
      realm.add(SearchItem(Uuid.v4().toString(), searchItem));
    });
  }

  @override
  Future<void> deleteSearchItemWithId(String id) async {
    final searchItem = realm.query<SearchItem>('id == "$id"').single;
    realm.write(() {
      realm.delete<SearchItem>(searchItem);
    });
  }

  @override
  Stream<List<SearchItem>> listenSearchItems() {
    final searchItems = realm.all<SearchItem>();
    return searchItems.changes.map(
      (event) => event.results
          .toList(growable: false)
          .reversed
          .take(3)
          .toList(growable: false),
    );
  }
}
