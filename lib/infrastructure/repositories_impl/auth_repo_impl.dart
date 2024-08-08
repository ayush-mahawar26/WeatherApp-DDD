import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_ddd/domain/repositories/auth_repo.dart';
import 'package:weather_ddd/infrastructure/datasource/auth_datasource.dart';

class AuthRepoImplementation extends AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepoImplementation({required this.authDataSource});

  @override
  Future<User?> signInUser(String email, String pass) async {
    return await authDataSource.signInUser(email, pass);
  }

  @override
  void signOut() async {
    authDataSource.signOut();
  }

  @override
  Future<User?> signUpUser(String email, String pass) async {
    return await authDataSource.signUpUser(email, pass);
  }
}
