import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:makharej_app/core/exceptions/login_exceptions.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth =
      FirebaseAuth.instanceFor(app: Firebase.app());
  UserCredential? _userCredential;
  UserCredential? get userCredential => _userCredential;

  User? getUser() {
    return _firebaseAuth.currentUser;
  }

  Future<Either<LoginException, bool>> loginUsingEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Either.right(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Either.left(UserNotFoundException());
      } else if (e.code == 'wrong-password') {
        return Either.left(InvalidCredentialsException());
      }
      return Either.left(UnknownLoginException());
    }
  }
}

class LoginResponse {}
