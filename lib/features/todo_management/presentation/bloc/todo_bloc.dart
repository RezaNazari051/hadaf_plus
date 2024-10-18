import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadaf_plus/core/params/update_todo_params.dart';
import 'package:hadaf_plus/core/resources/use_case.dart';
import 'package:hadaf_plus/features/todo_management/domain/use_cases/get_all_todo_usecase.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/add_new_todo_status.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/delete_todo_status.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/get_todos_status.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/todo_state.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/update_todo_status.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/use_cases/add_new_todo_usecase.dart';
import '../../domain/use_cases/delete_todo_usecase.dart';
import '../../domain/use_cases/update_todo_usecase.dart';

part 'todo_event.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetAllTodoUseCase _getAllTodoUseCase;
  final AddNewTodoUseCase _addNewTodoUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  final DeleteTodoUseCase _deleteTodoUseCase;

  TodoBloc(this._getAllTodoUseCase, this._addNewTodoUseCase, this._updateTodoUseCase, this._deleteTodoUseCase)
      : super(TodoState(getTodosStatus: GetTodosInitial(),
    addNewTodoStatus: AddNewTodoInitial(),
    updateTodoStatus: UpdateTodoInitial(),
    deleteTodoStatus: DeleteTodoInitial(),
  )) {
    on<GetAllTodosEvent>((event, emit) async {
      emit(state.copyWith(newGetTodoStatus: GetTodosLoading()));

      DataState dataState = await _getAllTodoUseCase(NoParams());
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newGetTodoStatus: GetTodosCompleted(dataState.data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(
            newGetTodoStatus: GetTodosError(dataState.error.toString())));
      }
    });


    on<AddTodoEvent>((event, emit) async {
      emit(state.copyWith(newAddTodoStatus: AddNewTodoLoading()));

      DataState dataState = await _addNewTodoUseCase(event.todo);
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newAddTodoStatus: AddNewTodoCompleted(dataState.data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(
            newAddTodoStatus: AddNewTodoFailed(dataState.error.toString())));
      }
    },);

    on<UpdateTodoEvent>((event, emit) async{
      emit(state.copyWith(newUpdateTodoStatus: UpdateTodoLoading()));

      DataState dataState = await _updateTodoUseCase(event.params);
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newUpdateTodoStatus: UpdateTodoCompleted(dataState.data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(
            newUpdateTodoStatus: UpdateTodoFailed(dataState.error.toString())));
      }
    });

    on<DeleteTodoEvent>((event, emit) async{
      emit(state.copyWith(newDeleteTodoStatus: DeleteTodoLoading()));

      DataState dataState = await _deleteTodoUseCase(event.id);
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newDeleteTodoStatus: DeleteTodoCompleted(dataState.data)));
      }
      if (dataState is DataFailed) {
        emit(state.copyWith(
            newDeleteTodoStatus: DeleteTodoFailed(dataState.error.toString())));
      }
    },);
  }
}
