import 'package:hadaf_plus/core/params/update_todo_params.dart';
import 'package:hadaf_plus/core/resources/data_state.dart';
import 'package:hadaf_plus/core/resources/use_case.dart';
import 'package:hadaf_plus/features/todo_management/domain/repository/todo_repository.dart';

class UpdateTodoUseCase extends UseCase<DataState<dynamic>,UpdateTodoParams>{
  final TodoRepository _todoRepository;
  UpdateTodoUseCase(this._todoRepository);
  @override
  Future<DataState> call(UpdateTodoParams param) {
    return _todoRepository.fetchUpdateTodo(param);
  }

}