import 'package:firebase_auth/firebase_auth.dart';

class AuthDataSource {
  final FirebaseAuth auth;

  AuthDataSource({required this.auth});

  Future<User?> signUpUser(String email, String pass) async {
    UserCredential userCredential =
        await auth.createUserWithEmailAndPassword(email: email, password: pass);
    print(userCredential.user!.uid);
    return userCredential.user;
  }

  Future<User?> signInUser(String email, String pass) async {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: pass);
    return userCredential.user;
  }

  void signOut() async {
    await auth.signOut();
  }
}
