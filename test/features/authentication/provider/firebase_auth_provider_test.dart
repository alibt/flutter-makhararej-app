import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:makharej_app/core/exceptions/auth_exception.dart';
import 'package:makharej_app/features/authentication/provider/firebase_auth_provider.dart';
import 'package:makharej_app/features/profile/model/makharej_user.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:mockito/mockito.dart';

import '../../../test_utils/mocks/mock_objects_list.mocks.dart';

//since mockito is not a suitable library to use for firebase auth unit
//testing and mocking, mock exception and mockFireBaseAuth, which is
//actually a fake not mock, is used here.

void main() {
  const email = "ali@gmail.com";
  const password = "Aa12345678!@";
  const email2 = "ali2@gmail.com";
  const password2 = "123456782";
  const invalidEmail1 = "a@a";
  const invalidEmail2 = "a@a.";
  const weakPassword1 = "11111111";
  const weakPassword2 = "1111111a";

  late MockFirebaseAuth mockFirebaseAuth;
  late FirebaseAuthProvider firebaseAuthProvider;
  late MockUserProvider mockUserProvider;
  group(
    "login with username and password",
    () {
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
          whenCalling(Invocation.method(#signInWithEmailAndPassword, null, {
            #email: email,
            #password: password
          })).on(mockFirebaseAuth).thenThrow(
              FirebaseAuthException(code: userNotFoundFirebaseExceptionCode));

          var result = await firebaseAuthProvider.loginUsingEmailAndPassword(
              email: email, password: password);

          expect(result.isLeft(), true);

          result.fold(
            (exception) {
              expect(exception is UserNotFoundException, true);
            },
            (flag) => null,
          );

          expect(
            await firebaseAuthProvider.loginUsingEmailAndPassword(
                email: email2, password: password2),
            right(true),
          );
        },
      );
      test(
        "Correct user name, wrong password should throw InvalidCredException",
        () async {
          whenCalling(Invocation.method(#signInWithEmailAndPassword, null, {
            #email: email,
            #password: password
          })).on(mockFirebaseAuth).thenThrow(
              FirebaseAuthException(code: wrongPasswordFirebaseExceptionCode));

          final result = await firebaseAuthProvider.loginUsingEmailAndPassword(
              email: email, password: password);
          expect(result.isLeft(), true);

          result.fold(
            (exception) {
              expect(exception is InvalidCredentialsException, true);
            },
            (flag) => null,
          );
        },
      );
      test(
        "A user name that doesn't exist should throw UserNotFoundException",
        () async {
          whenCalling(Invocation.method(#signInWithEmailAndPassword, null, {
            #email: email,
            #password: password
          })).on(mockFirebaseAuth).thenThrow(
              FirebaseAuthException(code: userNotFoundFirebaseExceptionCode));

          var result = await firebaseAuthProvider.loginUsingEmailAndPassword(
              email: email, password: password);

          expect(result.isLeft(), true);

          result.fold(
            (exception) {
              expect(exception is UserNotFoundException, true);
            },
            (flag) => null,
          );
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
        () async {
          whenCalling(
            Invocation.method(#signInWithEmailAndPassword, null, {
              #email: email,
              #password: password,
            }),
          ).on(mockFirebaseAuth).thenThrow(
                FirebaseException(
                    plugin: "", code: noAccessToFirebaseServiceCode),
              );
          var result = await firebaseAuthProvider.loginUsingEmailAndPassword(
            email: email,
            password: password,
          );
          expect(result.isLeft(), true);
          result.fold(
            (exception) {
              expect(exception is NoAccessToFireBaseServer, true);
            },
            (r) => null,
          );
        },
      );
      test(
        "Unknown Exception",
        () async {
          whenCalling(
            Invocation.method(#signInWithEmailAndPassword, null, {
              #email: email,
              #password: password,
            }),
          ).on(mockFirebaseAuth).thenThrow(
                Exception(),
              );
          var result = await firebaseAuthProvider.loginUsingEmailAndPassword(
            email: email,
            password: password,
          );
          expect(result.isLeft(), true);
          result.fold(
            (exception) {
              expect(exception is UnknownLoginException, true);
            },
            (r) => null,
          );
        },
      );
    },
  );

  group(
    "sign up using email and password",
    () {
      setUp(
        () {
          mockFirebaseAuth = MockFirebaseAuth();
          mockUserProvider = MockUserProvider();
          firebaseAuthProvider = FirebaseAuthProvider(
            firebaseAuth: mockFirebaseAuth,
            userProvider: mockUserProvider,
          );
        },
      );
      test("correct user name and correct password", () async {
        final user = MakharejUser(email: email, userID: email);
        when(mockUserProvider.registerNewUser(any)).thenAnswer((_) async {
          return Right(user);
        });
        var result =
            await firebaseAuthProvider.signUp(email: email, password: password);
        expect(result.isRight(), true);
        result.fold(
          (l) => null,
          (resultUser) {
            expect(resultUser.email, user.email);
          },
        );
      });
      test("invalid email exception", () async {
        var result = await firebaseAuthProvider.signUp(
            email: invalidEmail1, password: password);
        expect(result.isLeft(), true);
        result.fold(
          (exception) {
            expect(exception is InvalidEmailException, true);
          },
          (r) => null,
        );
        var result2 = await firebaseAuthProvider.signUp(
            email: invalidEmail2, password: password);
        expect(result2.isLeft(), true);
        result2.fold(
          (exception) {
            expect(exception is InvalidEmailException, true);
          },
          (r) => null,
        );
      });
      test("weak password", () async {
        var result = await firebaseAuthProvider.signUp(
            email: email, password: weakPassword1);
        expect(result.isLeft(), true);
        result.fold(
          (exception) {
            expect(exception is WeakPasswordException, true);
          },
          (r) => null,
        );
        var result2 = await firebaseAuthProvider.signUp(
            email: email, password: weakPassword2);
        expect(result2.isLeft(), true);
        result2.fold(
          (exception) {
            expect(exception is WeakPasswordException, true);
          },
          (r) => null,
        );
      });
      test("email already in use", () async {
        whenCalling(
          Invocation.method(#createUserWithEmailAndPassword, null, {
            #email: email,
            #password: password,
          }),
        ).on(mockFirebaseAuth).thenThrow(
              FirebaseAuthException(code: emailAlreadyInUseCode),
            );
        var result =
            await firebaseAuthProvider.signUp(email: email, password: password);
        expect(result.isLeft(), true);
        result.fold(
          (exception) {
            expect(exception is EmailAlreadyInUseException, true);
          },
          (r) => null,
        );
      });
      test("Unknown Register Exception", () async {
        whenCalling(
          Invocation.method(#createUserWithEmailAndPassword, null, {
            #email: email,
            #password: password,
          }),
        ).on(mockFirebaseAuth).thenThrow(
              FirebaseAuthException(code: "a code that is not valid"),
            );
        var result =
            await firebaseAuthProvider.signUp(email: email, password: password);
        expect(result.isLeft(), true);
        result.fold(
          (exception) {
            expect(exception is UnknownRegisterException, true);
          },
          (r) => null,
        );
      });
    },
  );
  group("login using google", () {});
}
