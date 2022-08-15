import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebaseinsta/models/failure.dart';
import 'package:firebaseinsta/repositories/storage/storage_repository.dart';
import 'package:firebaseinsta/repositories/user/user_repository.dart';
import 'package:firebaseinsta/screens/profile/bloc/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final ProfileBloc _profileBloc;
  final UserRepository _userRepository;
  final StorageRepository _storageRepository;

  EditProfileCubit({
    required UserRepository userRepository,
    required ProfileBloc profileBloc,
    required StorageRepository storageRepository,
  })  : _userRepository = userRepository,
        _profileBloc = profileBloc,
        _storageRepository = storageRepository,
        super(EditProfileState.initial()) {
    final user = _profileBloc.state.user;
    emit(state.copyWith(bio: user.bio, username: user.username));
  }

  void profileImageChanged(File image) {
    emit(state.copyWith(file: image, status: EditProfileStatus.initial));
  }

  void nameChanged(String name) {
    emit(state.copyWith(username: name, status: EditProfileStatus.initial));
  }

  void bioChanged(String value) {
    emit(state.copyWith(bio: value, status: EditProfileStatus.initial));
  }

  void submit() async {
    try {
      emit(state.copyWith(status: EditProfileStatus.submitting));
      final user = _profileBloc.state.user;
      //upload image
      String? imageUrl = user.profileImageUrl;

      if (state.file != null) {
        imageUrl = await _storageRepository.uploadProfileImage(
          path: user.profileImageUrl ?? 'profile',
          file: state.file!,
        );
      }

      final updatedUser = user.copyWith(
        username: state.username,
        bio: state.bio,
        profileImageUrl: imageUrl,
      );

      await _userRepository.updateUser(user: updatedUser);
      _profileBloc.add(ProfileLoadUser(userID: user.id));

      emit(
        EditProfileState(
          status: EditProfileStatus.success,
          username: state.username,
          bio: state.bio,
          file: null,
        ),
      );
    } on Failure {
      emit(
        EditProfileState(
          status: EditProfileStatus.error,
          username: state.username,
          bio: state.bio,
        ),
      );
    }
  }
}
