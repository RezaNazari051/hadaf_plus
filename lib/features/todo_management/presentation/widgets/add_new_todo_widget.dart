import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../bloc/add_new_todo_status.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_state.dart';

class AddNewTodoBottomSheet extends StatefulWidget {
  const AddNewTodoBottomSheet({super.key});

  @override
  State<AddNewTodoBottomSheet> createState() => _AddNewTodoBottomSheetState();
}

class _AddNewTodoBottomSheetState extends State<AddNewTodoBottomSheet> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
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
                  if (context.mounted) {
                    context.read<TodoBloc>().add(GetAllTodosEvent());
                  }
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
  }
}
