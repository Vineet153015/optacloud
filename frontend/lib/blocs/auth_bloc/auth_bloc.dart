import 'package:bloc/bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>(_onLogin);
    on<AuthLogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _auth.signInWithCredential(credential);
      emit(AuthAuthenticated(user: _auth.currentUser!));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    emit(AuthUnauthenticated());
  }
}
