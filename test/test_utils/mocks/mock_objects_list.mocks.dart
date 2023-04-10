// Mocks generated by Mockito 5.3.2 from annotations
// in makharej_app/test/test_utils/mocks/mock_objects_list.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:firebase_auth/firebase_auth.dart' as _i6;
import 'package:fpdart/fpdart.dart' as _i2;
import 'package:makharej_app/features/profile/model/makharej_user.dart' as _i5;
import 'package:makharej_app/features/profile/provider/user_provider.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [UserProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserProvider extends _i1.Mock implements _i3.UserProvider {
  @override
  _i4.Future<_i2.Either<Exception, _i5.MakharejUser>> getUser(String? uid) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUser,
          [uid],
        ),
        returnValue: _i4.Future<_i2.Either<Exception, _i5.MakharejUser>>.value(
            _FakeEither_0<Exception, _i5.MakharejUser>(
          this,
          Invocation.method(
            #getUser,
            [uid],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<Exception, _i5.MakharejUser>>.value(
                _FakeEither_0<Exception, _i5.MakharejUser>(
          this,
          Invocation.method(
            #getUser,
            [uid],
          ),
        )),
      ) as _i4.Future<_i2.Either<Exception, _i5.MakharejUser>>);
  @override
  _i4.Future<_i2.Either<Exception, _i5.MakharejUser>> registerNewUser(
          _i6.User? firebaseUser) =>
      (super.noSuchMethod(
        Invocation.method(
          #registerNewUser,
          [firebaseUser],
        ),
        returnValue: _i4.Future<_i2.Either<Exception, _i5.MakharejUser>>.value(
            _FakeEither_0<Exception, _i5.MakharejUser>(
          this,
          Invocation.method(
            #registerNewUser,
            [firebaseUser],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<Exception, _i5.MakharejUser>>.value(
                _FakeEither_0<Exception, _i5.MakharejUser>(
          this,
          Invocation.method(
            #registerNewUser,
            [firebaseUser],
          ),
        )),
      ) as _i4.Future<_i2.Either<Exception, _i5.MakharejUser>>);
  @override
  _i4.Future<void> updateUser(_i5.MakharejUser? user) => (super.noSuchMethod(
        Invocation.method(
          #updateUser,
          [user],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
