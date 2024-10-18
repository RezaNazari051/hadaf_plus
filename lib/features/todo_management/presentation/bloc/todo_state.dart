import 'package:hadaf_plus/features/todo_management/presentation/bloc/add_new_todo_status.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/delete_todo_status.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/get_todos_status.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/update_todo_status.dart';

class TodoState {
  TodoState({required this.getTodosStatus, required this.addNewTodoStatus,required this.updateTodoStatus,required this.deleteTodoStatus, });

  final GetTodosStatus getTodosStatus;
  final AddNewTodoStatus addNewTodoStatus;
  final UpdateTodoStatus updateTodoStatus;
  final DeleteTodoStatus deleteTodoStatus;

  TodoState copyWith(
      {GetTodosStatus? newGetTodoStatus, AddNewTodoStatus? newAddTodoStatus,
      UpdateTodoStatus? newUpdateTodoStatus, DeleteTodoStatus? newDeleteTodoStatus

      }) {
    return TodoState(
      getTodosStatus: newGetTodoStatus ?? getTodosStatus,
      addNewTodoStatus: newAddTodoStatus ?? addNewTodoStatus,
      updateTodoStatus: newUpdateTodoStatus?? updateTodoStatus,
      deleteTodoStatus: newDeleteTodoStatus?? deleteTodoStatus,
    );
  }
}
