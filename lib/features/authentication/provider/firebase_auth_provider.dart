import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:makharej_app/core/exceptions/auth_exception.dart';
import 'package:makharej_app/core/utils/extensions/string_extension.dart';
import 'package:makharej_app/features/profile/model/makharej_user.dart';
import 'package:makharej_app/features/profile/provider/user_provider.dart';

import 'base_auth_provider.dart';

const wrongPasswordFirebaseExceptionCode = "wrong-password";
const userNotFoundFirebaseExceptionCode = "user-not-found";
const noAccessToFirebaseServiceCode = "network-request-failed";
const invalidEmailCode = "invalid-email";
const weakPasswordCode = 'weak-password';
const emailAlreadyInUseCode = 'email-already-in-use';
const permissionDeniedCode = 'permission-denied';

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
        _userProvider = userProvider ?? UserProvider();

  @override
  Future<MakharejUser?> getUser() async {
    if (user != null) return user;
    var fireBaseUser = _firebaseAuth.currentUser;
    if (fireBaseUser != null) {
      var makharejUserResult = await _userProvider.getUser(fireBaseUser.uid);
      makharejUserResult.fold(
        (exception) => null,
        (newUser) {
          user = newUser;
        },
      );
    }
    return user;
  }

  @override
  Future<Either<AuthException, bool>> loginUsingEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == userNotFoundFirebaseExceptionCode) {
        return left(UserNotFoundException());
      }

      if (e.code == wrongPasswordFirebaseExceptionCode) {
        return left(InvalidCredentialsException());
      }

      if (e.code == invalidEmailCode) {
        return left(InvalidCredentialsException());
      }

      return left(UnknownLoginException(code: e.code));
    } on FirebaseException catch (e) {
      if (e.code == permissionDeniedCode) {
        return left((PermissionDeniedException()));
      }

      return left(UnknownLoginException(code: e.code));
    } catch (e) {
      return left(UnknownLoginException());
    }
  }

  //TODO(Ali) take register user in DB to a cloud function and trigger it
  //on firebase auth sign up event

  @override
  Future<Either<AuthException, MakharejUser>> loginUsingGoogle() async {
    try {
      final googleAccount = await _googleSignIn.signIn();
      final googleAuth = await googleAccount?.authentication;
      if (googleAuth == null) return left(GoogleLoginException());

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      var userCredentials =
          await _firebaseAuth.signInWithCredential(credential);
      if (userCredentials.user == null) return left(GoogleLoginException());

      Either<Exception, MakharejUser> registerationResult =
          await registerUserInDB(userCredentials);
      if (registerationResult.isRight()) {
        return right(user!);
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
      user = null;
      return right(true);
    } catch (e) {
      return left(LogoutException());
    }
  }

  @override
  Future<Either<AuthException, MakharejUser>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      if (!email.isEmail()) {
        return left(InvalidEmailException());
      }

      if (!password.isStrongPassword()) {
        return left(WeakPasswordException());
      }

      final userCredentials =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredentials.user != null) {
        Either<Exception, MakharejUser> registerationResult =
            await registerUserInDB(userCredentials);
        if (registerationResult.isRight()) {
          return right(user!);
        }
      }

      return left(UnknownRegisterException());
    } on FirebaseAuthException catch (e) {
      if (e.code == weakPasswordCode) {
        return left(WeakPasswordException());
      }

      if (e.code == emailAlreadyInUseCode) {
        return left(EmailAlreadyInUseException());
      }

      return left(UnknownRegisterException());
    } on FirebaseException catch (e) {
      if (e.code == permissionDeniedCode) {
        return left((PermissionDeniedException()));
      }

      return left(UnknownRegisterException());
    } catch (e) {
      return left(UnknownRegisterException());
    }
  }

  Future<Either<Exception, MakharejUser>> registerUserInDB(
      UserCredential userCredentials) async {
    final registerationResult =
        await _userProvider.registerNewUser(userCredentials.user!);
    registerationResult.fold(
      (exception) {
        throw exception;
      },
      (registeredUser) {
        user = registeredUser;
      },
    );
    return registerationResult;
  }
}
