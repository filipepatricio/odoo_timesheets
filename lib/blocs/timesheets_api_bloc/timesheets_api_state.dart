part of 'timesheets_api_bloc.dart';

abstract class TimesheetsApiState extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class TimesheetsApiErrorState extends TimesheetsApiState {
  final String error;

  TimesheetsApiErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class TimesheetsApiInitial extends TimesheetsApiState {}

class DataLoading extends TimesheetsApiState {}

class ProjectsLoaded extends TimesheetsApiState {
  final List<Project> projects;

  ProjectsLoaded(this.projects);

  @override
  List<Object> get props => [...projects];
}

class TasksLoaded extends TimesheetsApiState {
  final List<Task> tasks;

  TasksLoaded(this.tasks);

  @override
  List<Object> get props => [...tasks];
}

class TimesheetsApiProjectsRequestError extends TimesheetsApiErrorState {
  TimesheetsApiProjectsRequestError({required super.error});
}

class TimesheetsApiTasksRequestError extends TimesheetsApiErrorState {
  TimesheetsApiTasksRequestError({required super.error});
}
