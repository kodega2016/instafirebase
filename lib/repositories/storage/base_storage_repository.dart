import 'dart:io';

abstract class BaseStorageRepository {
  Future<String> uploadProfileImage({required String path, required File file});
  Future<String> uploadPostImage({required File file});
}
