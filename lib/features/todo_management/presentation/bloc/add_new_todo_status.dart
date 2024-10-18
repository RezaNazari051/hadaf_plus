import 'package:equatable/equatable.dart';

 abstract class AddNewTodoStatus extends Equatable{}


final class AddNewTodoInitial extends AddNewTodoStatus{
  @override
  List<Object?> get props => [];
}

final class AddNewTodoLoading extends AddNewTodoStatus{
  @override
  List<Object?> get props => [];
}

final class AddNewTodoCompleted extends AddNewTodoStatus{
   final String message;
   AddNewTodoCompleted(this.message);
  @override
  List<Object?> get props => [message];
}

final class AddNewTodoFailed extends AddNewTodoStatus{
  final String error;
  AddNewTodoFailed(this.error);
  @override
  List<Object?> get props => [error];
}