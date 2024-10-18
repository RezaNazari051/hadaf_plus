import 'package:hadaf_plus/core/resources/data_state.dart';
import 'package:hadaf_plus/core/resources/use_case.dart';
import 'package:hadaf_plus/features/todo_management/domain/entities/todo_entity.dart';
import 'package:hadaf_plus/features/todo_management/domain/repository/todo_repository.dart';

class GetAllTodoUseCase extends UseCase<DataState<ToDoEntity>, NoParams> {
  GetAllTodoUseCase(this._repository);
  final TodoRepository _repository;

  @override
  Future<DataState<ToDoEntity>> call(NoParams param) {
    return _repository.fetchGetALlTodos();
  }
}
