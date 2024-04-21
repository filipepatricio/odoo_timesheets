part of 'task_list_bloc.dart';

class TaskListState extends Equatable {
  const TaskListState({this.taskTimerList = const <TaskTimer>[]});

  final List<TaskTimer> taskTimerList;

  @override
  List<Object> get props => [taskTimerList];
}

final class TaskListInitial extends TaskListState {}
