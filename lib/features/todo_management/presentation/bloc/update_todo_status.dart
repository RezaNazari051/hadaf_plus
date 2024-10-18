import 'package:equatable/equatable.dart';

abstract class UpdateTodoStatus extends Equatable{}


final class UpdateTodoInitial extends UpdateTodoStatus{
  @override
  List<Object?> get props => [];
}

final class UpdateTodoLoading extends UpdateTodoStatus{
  @override
  List<Object?> get props => [];
}

final class UpdateTodoCompleted extends UpdateTodoStatus{
  final String message;
  UpdateTodoCompleted(this.message);
  @override
  List<Object?> get props => [message];
}

final class UpdateTodoFailed extends UpdateTodoStatus{
  final String error;
  UpdateTodoFailed(this.error);
  @override
  List<Object?> get props => [error];
}