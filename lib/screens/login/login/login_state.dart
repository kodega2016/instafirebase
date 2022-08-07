part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, success, error }

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
    this.loginStatus = LoginStatus.initial,
    this.failure,
  });

  final LoginStatus loginStatus;
  final String email;
  final String password;
  final Failure? failure;

  @override
  List<Object> get props => [loginStatus, email, password, failure ?? ''];

  factory LoginState.initial() {
    return const LoginState(loginStatus: LoginStatus.initial);
  }

  LoginState copyWith({
    final LoginStatus? loginStatus,
    final String? email,
    final String? password,
    final Failure? failure,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      failure: failure ?? this.failure,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }
}
