import 'package:hadaf_plus/core/params/update_todo_params.dart';
import 'package:hadaf_plus/core/resources/data_state.dart';
import 'package:hadaf_plus/features/todo_management/domain/entities/todo_entity.dart';

abstract class TodoRepository{
  Future <DataState<ToDoEntity>> fetchGetALlTodos();

  Future<DataState<dynamic>> fetchAddNewTodo(String todo);

  Future<DataState<dynamic>> fetchUpdateTodo(UpdateTodoParams params);

  Future<DataState<dynamic>> fetchDeleteTodo(int id);
}