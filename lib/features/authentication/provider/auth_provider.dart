import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:makharej_app/core/exceptions/auth_exception.dart';

class AuthProvider {
  final FirebaseAuth _firebaseAuth =
      FirebaseAuth.instanceFor(app: Firebase.app());
  UserCredential? _userCredential;
  UserCredential? get userCredential => _userCredential;

  User? getUser() {
    return _firebaseAuth.currentUser;
  }

  Future<Either<AuthException, bool>> loginUsingEmailAndPassword(
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

  Future<Either<AuthException, bool>> loginUsingGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleAccount = await googleSignIn.signIn();
      if (googleAccount?.authentication != null) {
        final googleAuth = await googleAccount!.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        return right(true);
      } else {
        return left(GoogleLoginException());
      }
    } catch (e) {
      return left(GoogleLoginException());
    }
  }

  Future<Either<LogoutException, bool>> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return right(true);
    } catch (e) {
      return left(LogoutException());
    }
  }

  Future<Either<AuthException, bool>> signUp(
      String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left(WeakPasswordException());
      } else if (e.code == 'email-already-in-use') {
        return Left(EmailAlreadyInUseException());
      }
      return left(UnknownRegisterException());
    } catch (e) {
      return Left(UnknownRegisterException());
    }
  }
}
