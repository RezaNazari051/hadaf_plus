import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:hadaf_plus/core/params/update_todo_params.dart';
import 'package:hadaf_plus/features/todo_management/domain/entities/todo_entity.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/get_todos_status.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/todo_bloc.dart';
import 'package:hadaf_plus/features/todo_management/presentation/bloc/todo_state.dart';
import 'package:hadaf_plus/features/todo_management/presentation/widgets/add_new_todo_widget.dart';

import '../widgets/slide_action.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    context.read<TodoBloc>().add(GetAllTodosEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo list',style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold ),),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
        return const AddNewTodoBottomSheet();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            BlocBuilder<TodoBloc, TodoState>(
              buildWhen: (previous, current) {
                return previous.getTodosStatus != current.getTodosStatus;
              },
              builder: (context, state) {
                if (state.getTodosStatus is GetTodosLoading) {
                  return SliverPadding(
                    padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height*0.4),
                    sliver: const SliverToBoxAdapter(
                      child: CupertinoActivityIndicator(
                        radius: 20,
                      ),
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
