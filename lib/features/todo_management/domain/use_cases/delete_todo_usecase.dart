import 'package:hadaf_plus/core/resources/data_state.dart';
import 'package:hadaf_plus/core/resources/use_case.dart';
import 'package:hadaf_plus/features/todo_management/domain/repository/todo_repository.dart';

class DeleteTodoUseCase extends UseCase<DataState<dynamic>,int>{
  final TodoRepository _repository;
  DeleteTodoUseCase(this._repository);
  @override
  Future<DataState> call(int param) {
   return _repository.fetchDeleteTodo(param);
  }
}