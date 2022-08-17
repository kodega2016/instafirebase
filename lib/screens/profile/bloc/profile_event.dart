part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLoadUser extends ProfileEvent {
  final String userID;
  const ProfileLoadUser({required this.userID});

  @override
  List<Object> get props => [userID];
}

class ProfileToggleGridView extends ProfileEvent {
  final bool isGridView;
  const ProfileToggleGridView({required this.isGridView});

  @override
  List<Object> get props => [isGridView];
}

class ProfilePostUpdate extends ProfileEvent {
  final List<PostModel> posts;

  const ProfilePostUpdate({required this.posts});

  @override
  List<Object> get props => [posts];
}
