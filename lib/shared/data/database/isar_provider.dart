import 'package:amplify_recipe/shared/data/model/notification.dart';
import 'package:amplify_recipe/shared/data/model/recipe.dart';
import 'package:amplify_recipe/shared/data/model/search_item.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarProvider {
  IsarProvider._();

  static late Isar isar;

  void close() {
    isar.close();
  }

  static Future<void> open() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = Isar.open(
      schemas: [
        NotificationSchema,
        RecipeSchema,
        SearchItemSchema,
      ],
      directory: dir.path,
    );
  }
}
