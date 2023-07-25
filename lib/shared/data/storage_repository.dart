abstract class StorageRepository {
  Future<String> uploadImage(
    String path,
    void Function(double progress) onProgressUpdate,
  );

  Future<String> generateDownloadUrl(String key);
}
