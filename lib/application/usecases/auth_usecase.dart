import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_ddd/domain/repositories/auth_repo.dart';

class AuthUseCase {
  final AuthRepository authRepo;

  AuthUseCase({required this.authRepo});

  Future<User?> signUpUser(String email, String pass) async {
    return await authRepo.signUpUser(email, pass);
  }

  Future<User?> signInUser(String email, String pass) async {
    return await authRepo.signInUser(email, pass);
  }

  void signout() {
    authRepo.signOut();
  }
}
