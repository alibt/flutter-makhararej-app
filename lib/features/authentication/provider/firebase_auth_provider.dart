import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:makharej_app/core/exceptions/auth_exception.dart';
import 'package:makharej_app/features/profile/model/user.dart';
import 'package:makharej_app/features/profile/provider/user_provider.dart';

import 'base_auth_provider.dart';

const wrongPasswordFirebaseExceptionCode = "wrong-password";
const userNotFoundFirebaseExceptionCode = "user-not-found";

class FirebaseAuthProvider extends BaseAuthProvider {
  final FirebaseAuth _firebaseAuth;
  final UserProvider _userProvider;
  MakharejUser? user;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthProvider({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    UserProvider? userProvider,
  })  : _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _userProvider = UserProvider();

//TODO (test) is the input correctly being sent to firebase auth,
//TODO (test) different types of responses and exceptions
//TODO what can go wrong?

  @override
  Future<Either<AuthException, bool>> loginUsingEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Either.right(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == userNotFoundFirebaseExceptionCode) {
        return Either.left(UserNotFoundException());
      } else if (e.code == wrongPasswordFirebaseExceptionCode) {
        return Either.left(InvalidCredentialsException());
      }
      return Either.left(UnknownLoginException());
    } catch (e) {
      return Either.left(UnknownLoginException());
    }
  }

  @override
  Future<Either<AuthException, MakharejUser>> loginUsingGoogle() async {
    try {
      final googleAccount = await _googleSignIn.signIn();
      final googleAuth = await googleAccount?.authentication;
      //TODO register user after registering google
      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        var userCredentials =
            await _firebaseAuth.signInWithCredential(credential);
        //this line is temp
        var makharejUser = MakharejUser(
            email: userCredentials.user?.email ?? "",
            userID: userCredentials.user?.uid ?? "");
        return right(makharejUser);
      } else {
        return left(GoogleLoginException());
      }
    } catch (e) {
      return left(GoogleLoginException());
    }
  }

  @override
  Future<Either<LogoutException, bool>> logout() async {
    try {
      await _firebaseAuth.signOut();
      return right(true);
    } catch (e) {
      return left(LogoutException());
    }
  }

  @override
  Future<Either<AuthException, MakharejUser>> signUp(
      String email, String password) async {
    try {
      UserCredential userCredentials =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredentials.user != null) {
        var registerationResult =
            await _userProvider.registerNewUser(userCredentials.user!);
        registerationResult.fold(
          (exception) {
            throw exception;
          },
          (registeredUser) {
            user = registeredUser;
          },
        );
        if (registerationResult.isRight()) {
          return right(user!);
        }
      }
      return left(UnknownRegisterException());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left(WeakPasswordException());
      } else if (e.code == 'email-already-in-use') {
        return Left(EmailAlreadyInUseException());
      }
      return left(UnknownRegisterException());
    } catch (e) {
      return left(UnknownRegisterException());
    }
  }
}
