import 'package:equatable/equatable.dart';

abstract class DeleteTodoStatus extends Equatable {}

final class DeleteTodoInitial extends DeleteTodoStatus {
  @override
  List<Object?> get props => [];
}

final class DeleteTodoLoading extends DeleteTodoStatus {
  @override
  List<Object?> get props => [];
}

final class DeleteTodoCompleted extends DeleteTodoStatus {
  final String message;

  DeleteTodoCompleted(this.message);

  @override
  List<Object?> get props => [];
}

final class DeleteTodoFailed extends DeleteTodoStatus {
  final String error;

  DeleteTodoFailed(this.error);

  @override
  List<Object?> get props => [];
}
