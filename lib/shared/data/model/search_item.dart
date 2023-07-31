import 'package:isar/isar.dart';

part 'search_item.g.dart';

@collection
class SearchItem {
  SearchItem({
    required this.id,
    required this.searchItem,
    required this.createdAt,
  });

  @Id()
  final String id;
  final String searchItem;
  final DateTime createdAt;
}
