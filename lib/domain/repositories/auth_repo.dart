import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> signUpUser(String email, String pass);
  Future<User?> signInUser(String email, String pass);
  void signOut();
}
