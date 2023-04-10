import 'package:bloc/bloc.dart';
import 'package:makharej_app/core/exceptions/auth_exception.dart';
import 'package:makharej_app/features/authentication/provider/firebase_auth_provider.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_event.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_state.dart';
import 'package:makharej_app/features/profile/model/makharej_user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthProvider authService;
  MakharejUser? user;

  AuthBloc(this.authService) : super(AuthInitState()) {
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
    emitter(state.copyWith(isLoading: true));

    var result = await authService.loginUsingEmailAndPassword(
        email: event.email, password: event.password);
    result.fold<void>(
      (exception) => onEmailLoginException(exception, emitter),
      (success) => onEmailLoginSuccess(emitter),
    );
  }

  void onEmailLoginSuccess(Emitter<AuthState> emitter) {
    emitter(AuthenticatedState(user: user));
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
    emitter(AuthenticationFailedState(
      message,
      isLoading: false,
    ));
  }

  Future<void> handleLogout(
    AuthEvent logoutEvent,
    Emitter<AuthState> emitter,
  ) async {
    try {
      emitter(state.copyWith(isLoading: true));
      var result = await authService.logout();
      result.fold(
        (logoutException) => emitter(state.copyWith(isLoading: false)),
        (r) {
          user = null;
          emitter(AuthInitState());
        },
      );
    } catch (e) {
      emitter(state.copyWith(isLoading: false));
    }
  }

  Future<void> handleLoginUsingGoogle(
    AuthEvent loginEvent,
    Emitter<AuthState> emitter,
  ) async {
    emitter(state.copyWith(isLoading: true));
    var result = await authService.loginUsingGoogle();
    result.fold(
      (l) => emitter(
        AuthenticationFailedState(
          l.message,
          isLoading: false,
        ),
      ),
      (r) => emitter(AuthenticatedState(
        user: user,
      )),
    );
  }

  Future<void> handleSignUp(
    SignUpEvent event,
    Emitter<AuthState> emitter,
  ) async {
    emitter(
      state.copyWith(isLoading: true),
    );
    var result =
        await authService.signUp(email: event.email, password: event.password);
    result.fold<void>(
      (exception) => onSignUpFailed(exception, emitter),
      (newUser) => onSignUpSuccess(emitter, newUser),
    );
  }

  void onSignUpSuccess(
    Emitter<AuthState> emitter,
    MakharejUser newUser,
  ) {
    user = newUser;
    emitter(RegistrationSuccess(user!));
  }

  void onSignUpFailed(
    AuthException exception,
    Emitter<AuthState> emitter,
  ) {
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
    emitter(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    if (user != null) {
      emitter(AuthenticatedState(isLoading: false, user: user));
      return;
    }
    emitter(UnAuthenticatedState());
  }
}
