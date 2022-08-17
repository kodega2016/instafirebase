import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebaseinsta/blocs/auth/auth_bloc.dart';
import 'package:firebaseinsta/models/models.dart';
import 'package:firebaseinsta/models/post_model.dart';
import 'package:firebaseinsta/repositories/posts/post_repository.dart';
import 'package:firebaseinsta/repositories/storage/storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final PostRepository _postRepository;
  final StorageRepository _storageRepository;
  final AuthBloc _authBloc;

  CreatePostCubit({
    required PostRepository postRepository,
    required StorageRepository storageRepository,
    required AuthBloc authBloc,
  })  : _postRepository = postRepository,
        _storageRepository = storageRepository,
        _authBloc = authBloc,
        super(CreatePostState.initial());

  void onChangeCaption(String val) {
    emit(state.copyWith(caption: val, status: CreatePostStatus.initial));
  }

  void onChangeFile(File file) {
    emit(state.copyWith(postImage: file, status: CreatePostStatus.initial));
  }

  Future<void> suvmit() async {
    try {
      emit(state.copyWith(status: CreatePostStatus.submitting));
      final author = User.empty.copyWith(id: _authBloc.state.user!.uid);
      final postImage =
          await _storageRepository.uploadPostImage(file: state.postImage!);

      final post = PostModel(
        caption: state.caption,
        user: author,
        date: DateTime.now(),
        imageUrl: postImage,
        likes: 0,
      );

      await _postRepository.createPost(post: post);
      emit(state.copyWith(status: CreatePostStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          failure: const Failure(
            code: '',
            message: 'We were unable to create your post.',
          ),
        ),
      );
    }
  }

  void reset() {
    emit(CreatePostState.initial());
  }
}
