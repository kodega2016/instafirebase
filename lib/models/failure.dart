import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String code;
  final String message;

  const Failure({required this.code, required this.message});

  @override
  List<Object> get props => [code];
}
