// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_profile_cubit.dart';

enum EditProfileStatus { initial, submitting, success, error }

class EditProfileState extends Equatable {
  const EditProfileState({
    required this.status,
    required this.username,
    required this.bio,
    this.file,
    this.failure,
  });

  final EditProfileStatus status;
  final String username;
  final String bio;
  final File? file;
  final Failure? failure;

  @override
  List<Object> get props => [username, bio, status, file ?? ''];

  factory EditProfileState.initial() {
    return const EditProfileState(
      status: EditProfileStatus.initial,
      username: '',
      bio: '',
    );
  }

  EditProfileState copyWith({
    EditProfileStatus? status,
    String? username,
    String? bio,
    File? file,
    Failure? failure,
  }) {
    return EditProfileState(
      status: status ?? this.status,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      file: file ?? this.file,
      failure: failure ?? this.failure,
    );
  }
}
