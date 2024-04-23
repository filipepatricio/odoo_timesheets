import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:odoo_apexive/blocs/bloc_exports.dart';
import 'package:odoo_apexive/data/models/project.dart';
import 'package:odoo_apexive/data/models/task.dart';
import 'package:odoo_apexive/data/repository/timesheets_repo.dart';

part 'timesheets_api_event.dart';
part 'timesheets_api_state.dart';

class TimesheetsApiBloc extends Bloc<TimesheetsApiEvent, TimesheetsApiState> {
  final TimesheetsRepoImpl timesheetsRepo;

  TimesheetsApiBloc(this.timesheetsRepo) : super(TimesheetsApiInitial()) {
    on<LoadProjectsEvent>(_onProjectsLoaded);
    on<LoadTasksEvent>(_onTasksLoaded);
  }

  FutureOr<void> _onProjectsLoaded(event, emit) async {
    emit(DataLoading());
    final projects = await timesheetsRepo.fetchProjects();
    emit(ProjectsLoaded(projects));
  }

  FutureOr<void> _onTasksLoaded(event, emit) async {
    emit(DataLoading());
    final tasks = await timesheetsRepo.fetchTasks(project: event.project);
    emit(TasksLoaded(tasks));
  }
}
