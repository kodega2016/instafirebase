import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseinsta/config/paths.dart';
import 'package:firebaseinsta/models/user_model.dart';
import 'package:firebaseinsta/repositories/user/base_user_repository.dart';

class UserRepository implements BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;
  UserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<User> getUserWithId(String id) async {
    final doc = await _firebaseFirestore.collection(Paths.users).doc(id).get();

    if (doc.exists) {
      return User.fromMap(doc.data()!, doc.id);
    } else {
      return User.empty;
    }
  }

  @override
  Future<void> updateUser({required User user}) async {
    await _firebaseFirestore
        .collection(Paths.users)
        .doc(user.id)
        .update(user.toMap());
  }
}
