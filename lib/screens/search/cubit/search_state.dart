// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

enum SearchStatus { initial, submitting, success, error }

class SearchState extends Equatable {
  const SearchState({
    required this.users,
    required this.status,
    this.failure,
  });

  final List<User> users;
  final SearchStatus status;
  final Failure? failure;

  @override
  List<Object> get props => [users, status, failure ?? ''];

  factory SearchState.initial() => const SearchState(
        users: <User>[],
        status: SearchStatus.initial,
      );

  SearchState copyWith({
    List<User>? users,
    SearchStatus? status,
    Failure? failure,
  }) {
    return SearchState(
      users: users ?? this.users,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
