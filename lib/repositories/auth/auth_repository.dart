import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebaseinsta/models/failure.dart';
import 'package:firebaseinsta/repositories/auth/base_auth_repository.dart';

class AuthRepository implements BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthRepository({
    auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<auth.User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final auth.UserCredential authCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = authCredential.user!;
      return user;
    } on auth.FirebaseAuthException catch (e) {
      throw Failure(code: e.code, message: e.message ?? '');
    }
  }

  @override
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  @override
  Future<auth.User> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final auth.UserCredential authCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = authCredential.user!;
      await user.updateDisplayName(name);

      await _firebaseFirestore.collection('users').doc(user.uid).set({
        'username': name,
        'email': email,
        'followers': 0,
        'following': 0,
      });

      return user;
    } on FirebaseException catch (e) {
      throw Failure(code: e.code, message: e.message ?? '');
    }
  }
}
