import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:makharej_app/core/exceptions/auth_exception.dart';

import '../../profile/model/makharej_user.dart';

abstract class BaseAuthProvider {
  Future<Either<AuthException, User>> loginUsingEmailAndPassword({
    required String email,
    required String password,
  });

  Future<MakharejUser?> getUser();

  Future<Either<AuthException, User>> loginUsingGoogle();
  Future<Either<LogoutException, bool>> logout();
  Future<Either<AuthException, User>> signUp({
    required String email,
    required String password,
  });
}
