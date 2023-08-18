import 'package:amplify_recipe/shared/data/storage_repository.dart';

class MockStorageRepository extends StorageRepository {
  @override
  Future<String> generateDownloadUrl(String key) {
    if (generatedImageLinksPerKey.containsKey(key)) {
      return Future.value(
        generatedImageLinksPerKey[key]!,
      );
    }
    generatedImageLinksPerKey.putIfAbsent(
      key,
      () => 'https://picsum.photos/200/300',
    );
    return Future.delayed(
      const Duration(seconds: 1),
      () => 'https://picsum.photos/200/300',
    );
  }

  @override
  Future<String> uploadImage(
    String path,
    void Function(double progress) onProgressUpdate,
  ) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => 'https://picsum.photos/200/300',
    );
  }
}
