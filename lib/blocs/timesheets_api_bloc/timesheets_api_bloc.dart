import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:odoo_apexive/blocs/bloc_exports.dart';
import 'package:odoo_apexive/data/api/result.dart';
import 'package:odoo_apexive/data/models/project.dart';
import 'package:odoo_apexive/data/models/task.dart';
import 'package:odoo_apexive/data/repository/timesheets_repo.dart';

part 'timesheets_api_event.dart';
part 'timesheets_api_state.dart';

class TimesheetsApiBloc extends Bloc<TimesheetsApiEvent, TimesheetsApiState> {
  final TimesheetsRepo timesheetsRepo;

  TimesheetsApiBloc(this.timesheetsRepo) : super(TimesheetsApiInitial()) {
    on<LoadProjectsEvent>(_loadProjects);
    on<LoadTasksEvent>(_loadTasks);
  }

  FutureOr<void> _loadProjects(event, emit) async {
    emit(DataLoading());
    final result = await timesheetsRepo.fetchProjects();
    switch (result) {
      case Success(value: final projects):
        emit(ProjectsLoaded(projects));
        break;
      case Failure(exception: final exception):
        emit(TimesheetsApiProjectsRequestError(error: exception.toString()));
        break;
    }
  }

  FutureOr<void> _loadTasks(event, emit) async {
    emit(DataLoading());
    final result = await timesheetsRepo.fetchTasks(project: event.project);
    switch (result) {
      case Success(value: final tasks):
        emit(TasksLoaded(tasks));
        break;
      case Failure(exception: final exception):
        emit(TimesheetsApiTasksRequestError(error: exception.toString()));
        break;
    }
  }
}
