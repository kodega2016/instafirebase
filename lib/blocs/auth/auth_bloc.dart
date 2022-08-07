import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseinsta/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  late StreamSubscription<User?>? _userSubs;

  AuthBloc({
    required this.authRepository,
  }) : super(AuthState.unknown()) {
    on<AuthUserChanged>((event, emit) {
      emit(AuthState.authenticating());
      if (event.user != null) {
        emit(AuthState.authenticated(user: event.user!));
      } else {
        emit(AuthState.unauthenticated());
      }
    });

    on<AuthLogoutRequest>((event, emit) async {
      emit(AuthState.authenticating());
      await authRepository.signOut();
      emit(AuthState.unauthenticated());
    });

    _userSubs = authRepository.user.listen((event) {
      if (event != null) {
        add(AuthUserChanged(user: event));
      } else {
        add(const AuthUserChanged(user: null));
      }
    });
  }

  @override
  Future<void> close() {
    _userSubs?.cancel();
    return super.close();
  }
}
