part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {}


final class GetAllTodosEvent extends TodoEvent{
  @override
  List<Object?> get props => [];
}

final class AddTodoEvent extends TodoEvent{
  final String todo;
  AddTodoEvent(this.todo);
  @override
  List<Object?> get props => [todo];

}
final class UpdateTodoEvent extends TodoEvent{
  final UpdateTodoParams params;
  UpdateTodoEvent(this.params);
  @override
  List<Object?> get props => [params];
}

final class DeleteTodoEvent extends TodoEvent{
  final int id;
  DeleteTodoEvent(this.id);
  @override
  List<Object?> get props => [id];

}
