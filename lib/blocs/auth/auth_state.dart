part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated, authenticating }

class AuthState extends Equatable {
  const AuthState({
    required this.authStatus,
    this.user,
  });

  final User? user;
  final AuthStatus authStatus;

  @override
  List<Object> get props => [user ?? '', authStatus];

  factory AuthState.unknown() =>
      const AuthState(authStatus: AuthStatus.unknown);

  factory AuthState.authenticating() =>
      const AuthState(authStatus: AuthStatus.authenticating);

  factory AuthState.authenticated({
    required User user,
  }) =>
      AuthState(
        authStatus: AuthStatus.authenticated,
        user: user,
      );

  factory AuthState.unauthenticated() =>
      const AuthState(authStatus: AuthStatus.unauthenticated);
}
