import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  User user;

  AuthenticationService(this._firebaseAuth) {
    this.user = _firebaseAuth.currentUser;
  }

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();
  User get getUser => user;

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future signIn({String email, String password}) async {
    try {
      User user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      this.user = user;
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  Future signUp({String email, String password}) async {
    try {
      User user = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      this.user = user;
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }
}
