import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:makharej_app/features/authentication/provider/auth_service.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_event.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, LoginState> {
  final AuthService authService;

  AuthBloc(this.authService)
      : super(const LoginState(state: LoginStatus.init)) {
    on<LoginWithEmailAndPasswordEvent>(handleSignInEvent);
  }

  Future<void> handleSignInEvent(
      AuthEvent loginEvent, Emitter<LoginState> emitter) async {
    if (loginEvent is LoginWithEmailAndPasswordEvent) {
      try {
        emitter(const LoginState(state: LoginStatus.loading));
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: loginEvent.email, password: loginEvent.password);

        emitter(
            const LoginState(state: LoginStatus.success, message: "success"));
      } catch (e) {
        emitter(LoginState(state: LoginStatus.failure, message: e.toString()));
      }
    }
  }
}
