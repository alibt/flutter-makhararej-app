import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:makharej_app/core/exceptions/auth_exception.dart';
import 'package:makharej_app/features/authentication/provider/auth_provider.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_event.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthProvider authService;
  User? get user => authService.getUser();

  AuthBloc(this.authService) : super(const AuthInitState(null)) {
    on<LoginWithEmailAndPasswordEvent>(handleSignInUsingEmailAndPassword);
    on<LogoutEvent>(handleLogout);
    on<LoginWithGoogleEvent>(handleLoginUsingGoogle);
    on<SignUpEvent>(handleSignUp);
    on<CheckAuthStateEvent>(onCheckAuthorizationState);
  }

  Future<void> handleSignInUsingEmailAndPassword(
    LoginWithEmailAndPasswordEvent event,
    Emitter<AuthState> emitter,
  ) async {
    emitter(LoadingAuthState(user));

    var result = await authService.loginUsingEmailAndPassword(
        email: event.email, password: event.password);
    result.fold<void>(
      (exception) => onEmailLoginException(exception, emitter),
      (success) => onEmailLoginSuccess(emitter),
    );
  }

  void onEmailLoginSuccess(Emitter<AuthState> emitter) {
    emitter(AuthorizedState(user));
  }

  void onEmailLoginException(
      AuthException loginException, Emitter<AuthState> emitter) {
    var message = "Unknown Exception";
    if (loginException is InvalidCredentialsException) {
      message = "Invalid Credentials";
    }
    if (loginException is UserNotFoundException) {
      message = "There's no account registered to this email.";
    }
    emitter(UnauthorizedState(user, message: message));
  }

  Future<void> handleLogout(
    AuthEvent logoutEvent,
    Emitter<AuthState> emitter,
  ) async {
    if (logoutEvent is LogoutEvent) {
      try {
        emitter(LoadingAuthState(user));
        var result = await authService.logout();
        result.fold(
          (logoutException) => emitter(AuthorizedState(user)),
          (r) => emitter(const UnauthorizedState(null)),
        );
      } catch (e) {
        emitter(AuthorizedState(user));
      }
    }
  }

  Future<void> handleLoginUsingGoogle(
    AuthEvent loginEvent,
    Emitter<AuthState> emitter,
  ) async {
    try {
      emitter(LoadingAuthState(user));
      var result = await authService.loginUsingGoogle();
      result.fold(
        (l) => emitter(const UnauthorizedState(null)),
        (r) => emitter(AuthorizedState(user)),
      );
    } catch (e) {
      emitter(UnauthorizedState(user));
    }
  }

  Future<void> handleSignUp(
      SignUpEvent event, Emitter<AuthState> emitter) async {
    emitter(LoadingAuthState(user));
    var result = await authService.signUp(event.email, event.password);
    result.fold<void>(
      (exception) => onSignUpFailed(exception, emitter),
      (r) => onSignUpSuccess(emitter),
    );
  }

  void onSignUpSuccess(Emitter<AuthState> emitter) {
    if (user != null) {
      emitter(AuthorizedState(user));
      return;
    }
    emitter(UnauthorizedState(user));
  }

  void onSignUpFailed(AuthException exception, Emitter<AuthState> emitter) {
    var message = "Unknown Error";
    if (exception is WeakPasswordException) {
      message = "Password is weak!";
    }
    if (exception is EmailAlreadyInUseException) {
      message = "An account is registered to this email";
    }
    emitter(RegisterationFailedState(message));
  }

  void onCheckAuthorizationState(
      CheckAuthStateEvent event, Emitter<AuthState> emitter) async {
    emitter(LoadingAuthState(user));
    await Future.delayed(const Duration(seconds: 1));
    if (user != null) {
      emitter(AuthorizedState(user));
      return;
    }
    emitter(UnauthorizedState(user));
  }
}
