// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:firebaseinsta/blocs/auth/auth_bloc.dart';
import 'package:firebaseinsta/models/failure.dart';
import 'package:firebaseinsta/models/post_model.dart';
import 'package:firebaseinsta/models/user_model.dart';
import 'package:firebaseinsta/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  final PostRepository _postRepository;
  final AuthBloc _authBloc;

  StreamSubscription? _postsSubscription;

  ProfileBloc({
    required UserRepository userRepository,
    required AuthBloc authBloc,
    required PostRepository postRepository,
  })  : _userRepository = userRepository,
        _postRepository = postRepository,
        _authBloc = authBloc,
        super(ProfileState.initial()) {
    on<ProfileLoadUser>(
      (event, emit) async {
        emit(state.copyWith(status: ProfileStatus.loading));
        try {
          final user = await _userRepository.getUserWithId(event.userID);
          final isCurrentUser = _authBloc.state.user?.uid == user.id;

          _postsSubscription?.cancel();
          _postsSubscription = _postRepository
              .getUserPosts(userID: user.id)
              .listen((posts) async {
            final allPosts = await Future.wait(posts);

            allPosts.removeWhere((element) => element == null);
            final all = allPosts.whereNotNull().toList();
            add(ProfilePostUpdate(posts: all));
          });

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
    on<ProfileToggleGridView>((event, emit) {
      emit(state.copyWith(isGridView: event.isGridView));
    });
    on<ProfilePostUpdate>((event, emit) {
      emit(state.copyWith(posts: event.posts));
    });
  }
}
