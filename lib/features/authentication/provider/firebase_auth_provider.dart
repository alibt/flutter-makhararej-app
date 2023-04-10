import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:makharej_app/core/exceptions/auth_exception.dart';
import 'package:makharej_app/core/utils/extensions/string_extension.dart';
import 'package:makharej_app/features/profile/model/makharej_user.dart';
import 'package:makharej_app/features/profile/provider/user_provider.dart';

import 'base_auth_provider.dart';

//TODO (test) is the input correctly being sent to firebase auth,
//TODO (test) different types of responses and exceptions
//TODO what can go wrong?

const wrongPasswordFirebaseExceptionCode = "wrong-password";
const userNotFoundFirebaseExceptionCode = "user-not-found";
const noAccessToFirebaseServiceCode = "network-request-failed";
const invalidEmailCode = "invalid-email";
const weakPasswordCode = 'weak-password';
const emailAlreadyInUseCode = 'email-already-in-use';

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
      return left(UnknownLoginException());
    } on FirebaseException catch (e) {
      if (e.code == noAccessToFirebaseServiceCode) {
        return left(NoAccessToFireBaseServer());
      }
      return left(UnknownLoginException());
    } catch (e) {
      return left(UnknownLoginException());
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
      UserCredential userCredentials =
          await _firebaseAuth.createUserWithEmailAndPassword(
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
      if (e.code == weakPasswordCode) {
        return left(WeakPasswordException());
      } else if (e.code == emailAlreadyInUseCode) {
        return left(EmailAlreadyInUseException());
      }
      return left(UnknownRegisterException());
    } catch (e) {
      return left(UnknownRegisterException());
    }
  }
}
