import 'package:equatable/equatable.dart';
import 'package:firebaseinsta/models/failure.dart';
import 'package:firebaseinsta/models/user_model.dart';
import 'package:firebaseinsta/repositories/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final UserRepository _userRepository;

  SearchCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(SearchState.initial());

  void searchUsers(String query) async {
    try {
      emit(state.copyWith(status: SearchStatus.submitting));
      final users = await _userRepository.searchUser(query: query);
      emit(state.copyWith(users: users, status: SearchStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: SearchStatus.error,
          failure: Failure(code: '', message: e.toString()),
        ),
      );
    }
  }

  void clearSearch() async {
    emit(SearchState.initial());
  }
}
