import 'package:realm/realm.dart';
part 'recipe.g.dart';

@RealmModel()
class _Recipe {
  @PrimaryKey()
  late String id;
  late String title;
  late String description;
  late int serve;
  late String duration;
  late String category;
  late String image;
  late bool isFavorited;
  late List<String> ingredients;
  bool isSynced = false;
}
