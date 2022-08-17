import 'package:firebaseinsta/models/user_model.dart';

abstract class BaseUserRepository {
  Future<User> getUserWithId(String id);
  Future<void> updateUser({required User user});
  Future<List<User>> searchUser({required String query});
}
