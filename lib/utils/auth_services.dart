import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final firebaseAuth = FirebaseAuth.instance;

  //login
  Future<User?> login(String email, String password) async {
    UserCredential result =
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result.user;
  }

  //sign up
  Future<User?> register(String email, String password) async {
    UserCredential result =
    await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result.user;
  }

  //logout
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  Future<void> forgotPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(
      email: email,
    );
  }
}