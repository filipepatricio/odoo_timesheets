part of 'task_list_bloc.dart';

sealed class TaskListEvent extends Equatable {
  const TaskListEvent();

  @override
  List<Object> get props => [];
}

class AddTaskTimer extends TaskListEvent {
  final TaskTimer taskTimer;
  const AddTaskTimer({
    required this.taskTimer,
  });

  @override
  List<Object> get props => [taskTimer];
}
