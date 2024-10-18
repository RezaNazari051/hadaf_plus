import 'package:equatable/equatable.dart';
import 'package:hadaf_plus/features/todo_management/domain/entities/todo_entity.dart';

abstract class GetTodosStatus extends Equatable {}

final class GetTodosInitial extends GetTodosStatus {
  @override
  List<Object?> get props => [];
}

final class GetTodosLoading extends GetTodosStatus {
  @override
  List<Object?> get props => [];
}

final class GetTodosCompleted extends GetTodosStatus {
  final ToDoEntity todoEntity;
  GetTodosCompleted(this.todoEntity);
  @override
  List<Object?> get props => [todoEntity];
}

final class GetTodosError extends GetTodosStatus {
  GetTodosError(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
