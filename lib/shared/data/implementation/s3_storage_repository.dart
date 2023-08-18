import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_recipe/shared/data/storage_repository.dart';

class S3StorageRepository extends StorageRepository {
  @override
  Future<String> generateDownloadUrl(String key) async {
    if (generatedImageLinksPerKey.containsKey(key)) {
      return generatedImageLinksPerKey[key]!;
    }
    final result = await Amplify.Storage.getUrl(
      key: key,
      options: const StorageGetUrlOptions(
        accessLevel: StorageAccessLevel.guest,
      ),
    ).result;
    final link = result.url.toString();
    generatedImageLinksPerKey.putIfAbsent(key, () => link);
    return link;
  }

  @override
  Future<String> uploadImage(
    String path,
    void Function(double progress) onProgressUpdate,
  ) async {
    final key = UUID.getUUID();
    await Amplify.Storage.uploadFile(
      localFile: AWSFile.fromPath(path),
      key: '$key.jpg',
      options: const StorageUploadFileOptions(
        accessLevel: StorageAccessLevel.guest,
      ),
      onProgress: (progress) {
        onProgressUpdate(progress.fractionCompleted);
      },
    ).result;
    return key;
  }
}
