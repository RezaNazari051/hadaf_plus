import 'package:equatable/equatable.dart';

import '../../data/model/todo_model.dart';

class ToDoEntity extends Equatable{
 final List<Todo>? todos;
 final int? total;
 final int? skip;
 final int? limit;

 const ToDoEntity({
   this.todos,
   this.total,
   this.skip,
   this.limit,
});
  @override
  List<Object?> get props => [todos,total,skip,limit];

}