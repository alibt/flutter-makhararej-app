import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:makharej_app/core/exceptions/auth_exception.dart';
import 'package:makharej_app/features/authentication/provider/firebase_auth_provider.dart';
import 'package:mock_exceptions/mock_exceptions.dart';

//since mockito is not a suitable library to use for firebase auth unit
//testing and mocking, mock exception and mockFireBaseAuth, which is
//actually a fake not mock, is used here.

void main() {
  group(
    "login with username and password",
    () {
      const email = "ali@gmail.com";
      const password = "12345678";

      late MockFirebaseAuth mockFirebaseAuth;
      late FirebaseAuthProvider firebaseAuthProvider;

      setUp(
        () {
          mockFirebaseAuth = MockFirebaseAuth();
          firebaseAuthProvider = FirebaseAuthProvider(
            firebaseAuth: mockFirebaseAuth,
          );
        },
      );
      tearDown(
        () {},
      );

      test(
        "verify username and password is passed to firebaseAuth",
        () async {
          whenCalling(Invocation.method(#signInWithEmailAndPassword, null,
                  {#email: email, #password: password}))
              .on(mockFirebaseAuth)
              .thenThrow(FirebaseAuthException(code: "bla"));

          var result = await firebaseAuthProvider.loginUsingEmailAndPassword(
              email: email, password: password);

          expect(result.isLeft(), true);
        },
      );
      test(
        "Correct user name, wrong password",
        () async {
          whenCalling(Invocation.method(#signInWithEmailAndPassword, null, {
            #email: email,
            #password: password
          })).on(mockFirebaseAuth).thenThrow(
              FirebaseAuthException(code: wrongPasswordFirebaseExceptionCode));

          final result = await firebaseAuthProvider.loginUsingEmailAndPassword(
              email: email, password: password);

          expect(result.isLeft(), true);

          expect(result.mapLeft((e) => e.runtimeType),
              isA<InvalidCredentialsException>());
        },
      );
      test(
        "A user name that doesn't exist",
        () async {
          whenCalling(Invocation.method(#signInWithEmailAndPassword, null, {
            #email: email,
            #password: password
          })).on(mockFirebaseAuth).thenThrow(
              FirebaseAuthException(code: userNotFoundFirebaseExceptionCode));

          var result = await firebaseAuthProvider.loginUsingEmailAndPassword(
              email: email, password: password);

          expect(result.isLeft(), true);

          expect(result.mapLeft((e) => e.runtimeType),
              isA<UserNotFoundException>());
        },
      );
      test(
        "correct user name and correct password",
        () async {
          var result = await firebaseAuthProvider.loginUsingEmailAndPassword(
              email: email, password: password);

          expect(result.isRight(), true);
        },
      );
      test(
        "network error",
        () {},
      );
      test(
        "Unknown Exception",
        () {},
      );
    },
  );
}
