part of 'signup_cubit.dart';

enum SignUpStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  const SignupState({
    required this.name,
    required this.email,
    required this.password,
    this.signUpStatus = SignUpStatus.initial,
    this.failure,
  });

  final SignUpStatus signUpStatus;
  final String name;
  final String email;
  final String password;
  final Failure? failure;

  @override
  List<Object> get props => [signUpStatus, name, email, password];

  bool get isFormValid =>
      name.isEmpty && email.isNotEmpty && password.isNotEmpty;

  factory SignupState.initial() {
    return const SignupState(
      name: '',
      email: '',
      password: '',
      signUpStatus: SignUpStatus.initial,
    );
  }

  SignupState copyWith({
    final String? name,
    final SignUpStatus? signUpStatus,
    final String? email,
    final String? password,
    final Failure? failure,
  }) {
    return SignupState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      failure: failure ?? this.failure,
      signUpStatus: signUpStatus ?? this.signUpStatus,
    );
  }
}
