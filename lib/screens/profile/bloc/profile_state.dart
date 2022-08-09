// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  const ProfileState({
    this.isCurrentUser = false,
    this.isGridView = false,
    this.status = ProfileStatus.initial,
    this.isFollowing = false,
    required this.user,
    this.failure,
  });

  final User user;
  // final List<Post> posts;
  final bool isCurrentUser;
  final bool isGridView;
  final ProfileStatus status;
  final Failure? failure;
  final bool isFollowing;

  @override
  List<Object> get props => [user, isCurrentUser, isGridView];

  factory ProfileState.initial() {
    return const ProfileState(user: User.empty);
  }

  ProfileState copyWith({
    User? user,
    bool? isCurrentUser,
    bool? isGridView,
    ProfileStatus? status,
    Failure? failure,
    bool? isFollowing,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
      isGridView: isGridView ?? this.isGridView,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}
