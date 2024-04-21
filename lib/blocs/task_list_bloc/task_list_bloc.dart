import 'package:equatable/equatable.dart';
import 'package:odoo_apexive/blocs/bloc_exports.dart';
import 'package:odoo_apexive/models/task_timer.dart';

part 'task_list_event.dart';
part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  TaskListBloc() : super(TaskListInitial()) {
    on<AddTaskTimer>(_onAddTaskTimer);
  }

  void _onAddTaskTimer(AddTaskTimer event, Emitter<TaskListState> emit) {
    emit(TaskListState(
        taskTimerList: List.from(state.taskTimerList)..add(event.taskTimer)));
  }
}
