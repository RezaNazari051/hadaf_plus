import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:hadaf_plus/core/params/update_todo_params.dart';
import 'package:hadaf_plus/features/todo_management/domain/entities/todo_entity.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/add_new_todo_status.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/delete_todo_status.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/get_todos_status.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/todo_bloc.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/todo_state.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/update_todo_status.dart';

import '../widgets/slide_action.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    context.read<TodoBloc>().add(GetAllTodosEvent());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              final border = OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15));

              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'TODO:',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: border,
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: BlocConsumer<TodoBloc, TodoState>(
                        buildWhen: (previous, current) {
                          return previous.addNewTodoStatus !=
                              current.addNewTodoStatus;
                        },
                        listenWhen: (previous, current) {
                          return previous.addNewTodoStatus !=
                              current.addNewTodoStatus;
                        },
                        listener: (context, state) {
                          if (state.addNewTodoStatus is AddNewTodoCompleted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Todo saved successfully'),
                              duration: Duration(seconds: 2),
                            ));
                            Navigator.pop(context);
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                MediaQuery.sizeOf(context).width,
                                48,
                              ),
                            ),
                            onPressed: () {
                              if (_controller.text.isNotEmpty) {
                                context
                                    .read<TodoBloc>()
                                    .add(AddTodoEvent(_controller.text));
                              }
                            },
                            child: state.addNewTodoStatus is AddNewTodoLoading
                                ? const CupertinoActivityIndicator()
                                : const Text('Save'),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          ).whenComplete(
            () {
              if (context.mounted) {
                context.read<TodoBloc>().add(GetAllTodosEvent());
              }
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            BlocConsumer<TodoBloc, TodoState>(
              buildWhen: (previous, current) {
                return previous.getTodosStatus != current.getTodosStatus;
              },
              listenWhen: (previous, current) {
                return previous.deleteTodoStatus != current.deleteTodoStatus ||
                    previous.updateTodoStatus != current.updateTodoStatus;
              },
              listener: (context, state) {
                if (state.deleteTodoStatus is DeleteTodoCompleted) {
                  context.read<TodoBloc>().add(GetAllTodosEvent());
                }
                if (state.updateTodoStatus is UpdateTodoCompleted) {
                  context.read<TodoBloc>().add(GetAllTodosEvent());
                }
              },
              builder: (context, state) {
                if (state.getTodosStatus is GetTodosLoading) {
                  return const SliverToBoxAdapter(
                    child: CupertinoActivityIndicator(
                      radius: 20,
                    ),
                  );
                } else if (state.getTodosStatus is GetTodosError) {
                  return SliverToBoxAdapter(
                    child: Row(
                      children: [
                        const Text('Failed to load data'),
                        const Gap(20),
                        TextButton(
                            onPressed: () {
                              context.read<TodoBloc>().add(GetAllTodosEvent());
                            },
                            child: const Text('Try again')),
                      ],
                    ),
                  );
                } else if (state.getTodosStatus is GetTodosCompleted) {
                  final GetTodosCompleted todoCompleted =
                      state.getTodosStatus as GetTodosCompleted;
                  final ToDoEntity todoEntity = todoCompleted.todoEntity;

                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final todo = todoEntity.todos![index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Slidable(
                          startActionPane: ActionPane(
                              motion: const BehindMotion(),
                              children: [
                                SlideAction(
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  onPressed: (context) {
                                    if (todo.id != null) {
                                      context
                                          .read<TodoBloc>()
                                          .add(DeleteTodoEvent(todo.id!));
                                    }
                                  },
                                ),
                                SlideAction(
                                  color: todo.completed!
                                      ? Colors.blue
                                      : Colors.green,
                                  icon: Icons.check,
                                  label: todo.completed! ? 'Uncheck' : 'Check',
                                  onPressed: (context) {
                                    if (todo.id != null) {
                                      final UpdateTodoParams params =
                                          UpdateTodoParams(
                                              todo.id!, !todo.completed!);
                                      context
                                          .read<TodoBloc>()
                                          .add(UpdateTodoEvent(params));
                                    }
                                  },
                                ),
                              ]),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            tileColor: const Color(0xff262626),
                            title: Text(
                              todo.todo.toString(),
                              style: TextStyle(
                                  decoration: todo.completed!
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: todo.completed!
                                      ? Colors.grey
                                      : Colors.white),
                            ),
                          ),
                        ),
                      );
                    }, childCount: todoEntity.todos?.length),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
          ],
        ),
      ),
    );
  }
}
