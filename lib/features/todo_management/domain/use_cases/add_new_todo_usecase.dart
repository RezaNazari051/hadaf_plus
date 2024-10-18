import 'package:hadaf_plus/core/resources/data_state.dart';
import 'package:hadaf_plus/core/resources/use_case.dart';

import '../repository/todo_repository.dart';

class AddNewTodoUseCase extends UseCase<DataState<dynamic>,String>{
  AddNewTodoUseCase(this._repository);
  final TodoRepository _repository;

  @override
  Future<DataState<dynamic>> call(String param) {
    return _repository.fetchAddNewTodo(param);
  }
}