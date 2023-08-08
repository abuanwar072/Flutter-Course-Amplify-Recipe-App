import 'package:amplify_recipe/shared/data/model/recipe.dart';
import 'package:amplify_recipe/shared/data/model/search_item.dart';

abstract class SearchRepository {
  Future<List<SearchItem>> getSearchItems();

  Future<List<Recipe>> searchRecipes(String searchTerm);

  Future<void> deleteAllSearchItems();

  Future<void> saveSearchItem(String searchItem);

  Future<void> deleteSearchItemWithId(String id);
}
