import 'package:equatable/equatable.dart';
import 'package:firebaseinsta/models/failure.dart';
import 'package:firebaseinsta/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(LoginState.initial());

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  bool get isFormValid => state.email.isNotEmpty && state.password.isNotEmpty;

  void loginWithCredentials() async {
    try {
      if (state.loginStatus == LoginStatus.submitting || !isFormValid) return;

      emit(state.copyWith(loginStatus: LoginStatus.submitting));
      await _authRepository.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(loginStatus: LoginStatus.success));
    } on Failure catch (e) {
      emit(state.copyWith(loginStatus: LoginStatus.error, failure: e));
    }
  }
}
