import 'package:fpdart/fpdart.dart';
import 'package:makharej_app/core/exceptions/auth_exception.dart';

import '../../profile/model/makharej_user.dart';

abstract class BaseAuthProvider {
  Future<Either<AuthException, bool>> loginUsingEmailAndPassword(
      {required String email, required String password});

  Future<Either<AuthException, MakharejUser>> loginUsingGoogle();
  Future<Either<LogoutException, bool>> logout();
  Future<Either<AuthException, MakharejUser>> signUp(
      String email, String password);
}
