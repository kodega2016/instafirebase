import 'package:equatable/equatable.dart';
import 'package:firebaseinsta/models/models.dart';
import 'package:firebaseinsta/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository authRepository;
  SignupCubit({required this.authRepository}) : super(SignupState.initial());

  void changeName(String name) {
    emit(state.copyWith(name: name));
  }

  void changeEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void changePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void signUpWithEmailAndPassword() async {
    try {
      emit(state.copyWith(signUpStatus: SignUpStatus.submitting));
      await authRepository.signUpWithEmailAndPassword(
        name: state.name,
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(signUpStatus: SignUpStatus.success));
    } on Failure catch (e) {
      emit(state.copyWith(failure: e, signUpStatus: SignUpStatus.error));
    }
  }
}
