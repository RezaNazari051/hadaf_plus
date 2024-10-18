import 'package:dio/dio.dart';
import 'package:hadaf_plus/core/params/update_todo_params.dart';
import 'package:hadaf_plus/core/utils/constants.dart';

class ApiProvider {
  final Dio _dio;

  ApiProvider(this._dio);

  Future<dynamic> callGetAllToDos() async {
    final response = await _dio
        .get('${Constants.baseUrl}/todos', queryParameters: {'limit': 10});
    return response;
  }

  Future<dynamic> addNewTodo(String todo) async {
    final response = await _dio.post('${Constants.baseUrl}/todos/add',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          'todo': todo,
          'completed': false,
          'userId': 1,
        });
    return response;
  }

  Future<dynamic> updateTodo(UpdateTodoParams params) async {
    final response=await _dio.put('${Constants.baseUrl}/todos/${params.id}',
        data: {'completed': params.completed});
    return response;
  }

  Future<dynamic>deleteTodo(int id)async{
    final response=await _dio.delete('${Constants.baseUrl}/todo/$id');
    return response;
  }
}
