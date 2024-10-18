import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hadaf_plus/features/todo_management/data/data_source/remote/api_provider.dart';
import 'package:hadaf_plus/features/todo_management/data/repository/todo_repository_implementation.dart';
import 'package:hadaf_plus/features/todo_management/domain/repository/todo_repository.dart';
import 'package:hadaf_plus/features/todo_management/domain/use_cases/add_new_todo_usecase.dart';
import 'package:hadaf_plus/features/todo_management/domain/use_cases/get_all_todo_usecase.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/todo_bloc.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

import 'features/todo_management/domain/use_cases/delete_todo_usecase.dart';
import 'features/todo_management/domain/use_cases/update_todo_usecase.dart';

final GetIt locator = GetIt.instance;

Future<void> initLocator() async {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  )..interceptors.add(TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
      printRequestData: true,
      printResponseMessage: true,
    )));
  locator.registerSingleton<Dio>(dio);

  ///Api providers
  locator.registerSingleton<ApiProvider>(ApiProvider(locator<Dio>()));

  ///Repositories
  locator.registerSingleton<TodoRepository>(
      TodoRepositoryImpl(locator<ApiProvider>()));

  ///UseCases
  locator.registerSingleton<GetAllTodoUseCase>(
      GetAllTodoUseCase(locator<TodoRepository>()));
  locator.registerSingleton<AddNewTodoUseCase>(
      AddNewTodoUseCase(locator<TodoRepository>()));
  locator.registerSingleton<UpdateTodoUseCase>(
      UpdateTodoUseCase(locator<TodoRepository>()));
  locator.registerSingleton<DeleteTodoUseCase>(
      DeleteTodoUseCase(locator<TodoRepository>()));

  ///Blocs
  locator.registerSingleton<TodoBloc>(TodoBloc(
    locator<GetAllTodoUseCase>(),
    locator<AddNewTodoUseCase>(),
    locator<UpdateTodoUseCase>(),
    locator<DeleteTodoUseCase>(),
  ));
}
