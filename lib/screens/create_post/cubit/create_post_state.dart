// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_post_cubit.dart';

enum CreatePostStatus { initial, submitting, success, error }

class CreatePostState extends Equatable {
  const CreatePostState({
    required this.caption,
    required this.postImage,
    required this.status,
    this.failure,
  });

  final String caption;
  final File? postImage;
  final CreatePostStatus status;
  final Failure? failure;

  @override
  List<Object> get props => [caption, postImage ?? '', status, failure ?? ''];

  factory CreatePostState.initial() {
    return const CreatePostState(
      caption: '',
      postImage: null,
      status: CreatePostStatus.initial,
    );
  }

  CreatePostState copyWith({
    String? caption,
    File? postImage,
    CreatePostStatus? status,
    Failure? failure,
  }) {
    return CreatePostState(
      caption: caption ?? this.caption,
      postImage: postImage ?? this.postImage,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
