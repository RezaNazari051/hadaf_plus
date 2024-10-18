import 'package:dio/dio.dart';
import 'package:hadaf_plus/core/params/update_todo_params.dart';
import 'package:hadaf_plus/core/resources/data_state.dart';
import 'package:hadaf_plus/features/todo_management/data/data_source/remote/api_provider.dart';
import 'package:hadaf_plus/features/todo_management/data/model/todo_model.dart';
import 'package:hadaf_plus/features/todo_management/domain/entities/todo_entity.dart';
import 'package:hadaf_plus/features/todo_management/domain/repository/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  final ApiProvider _apiProvider;

  TodoRepositoryImpl(this._apiProvider);

  @override
  Future<DataState<ToDoEntity>> fetchGetALlTodos() async {
    try {
      Response response = await _apiProvider.callGetAllToDos();
      if (response.statusCode == 200) {
        ToDoEntity todoEntity = TodoModel.fromJson(response.data);
        return DataSuccess(todoEntity);
      } else {
        return const DataFailed('Please try again...');
      }
    } catch (e) {
      return const DataFailed('Please check your network connection...');
    }
  }

  @override
  Future<DataState> fetchAddNewTodo(String todo) async {
    try {
      Response response = await _apiProvider.addNewTodo(todo);
      if (response.statusCode == 201) {
        return const DataSuccess('add todo successfully');
      } else {
        return const DataFailed('add todo failed');
      }
    } catch (e) {
      return const DataFailed('please check your connection...');
    }
  }

  @override
  Future<DataState> fetchUpdateTodo(UpdateTodoParams params) async {
    try {
      Response response = await _apiProvider.updateTodo(params);
      if (response.statusCode == 200) {
        return const DataSuccess('update todo successfully');
      } else {
        return const DataFailed('update todo failed');
      }
    } catch (e) {
      return const DataFailed('please check your connection...');
    }
  }

  @override
  Future<DataState> fetchDeleteTodo(int id) async {
    try {
      Response response = await _apiProvider.deleteTodo(id);
      if (response.statusCode == 200) {
        return const DataSuccess('delete todo successfully');
      } else {
        return const DataFailed('delete todo failed');
      }
    } catch (e) {
      return const DataFailed('please check your connection...');
    }
  }
}
