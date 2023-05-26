import 'package:realm/realm.dart';

part 'search_item.g.dart';

@RealmModel()
class _SearchItem {
  @PrimaryKey()
  late String id;
  late String searchItem;
}
