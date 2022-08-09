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
