import 'package:equatable/equatable.dart';
import 'package:firebaseinsta/blocs/auth/auth_bloc.dart';
import 'package:firebaseinsta/models/failure.dart';
import 'package:firebaseinsta/models/user_model.dart';
import 'package:firebaseinsta/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  final AuthBloc _authBloc;

  ProfileBloc({
    required UserRepository userRepository,
    required AuthBloc authBloc,
  })  : _userRepository = userRepository,
        _authBloc = authBloc,
        super(ProfileState.initial()) {
    on<ProfileLoadUser>(
      (event, emit) async {
        emit(state.copyWith(status: ProfileStatus.loading));
        try {
          final user = await _userRepository.getUserWithId(event.userID);
          final isCurrentUser = _authBloc.state.user?.uid == user.id;

          emit(state.copyWith(
            user: user,
            isCurrentUser: isCurrentUser,
            status: ProfileStatus.loaded,
          ));
        } on Failure catch (e) {
          emit(state.copyWith(status: ProfileStatus.error, failure: e));
        }
      },
    );
  }
}
