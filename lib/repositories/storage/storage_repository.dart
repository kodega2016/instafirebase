import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseinsta/repositories/storage/base_storage_repository.dart';
import 'package:flutter/foundation.dart';

class StorageRepository extends BaseStorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({FirebaseStorage? firebaseStorage})
      : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  @override
  Future<String> uploadPostImage({required File file}) async {
    final id = DateTime.now().toIso8601String();
    final path = 'images/posts/post_$id.jpg';
    return await _uploadFile(file: file, path: path);
  }

  @override
  Future<String> uploadProfileImage({
    required String path,
    required File file,
  }) async {
    return await _uploadFile(file: file, path: path);
  }

  Future<String> _uploadFile({
    required String path,
    required File file,
  }) async {
    UploadTask uploadTask;
    Reference ref = _firebaseStorage.ref().child(path);

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes());
    } else {
      uploadTask = ref.putFile(File(file.path));
    }

    final data = await uploadTask;
    final url = data.ref.getDownloadURL();
    return url;
  }
}
