part of 'timesheets_api_bloc.dart';

abstract class TimesheetsApiState {}

class TimesheetsApiInitial extends TimesheetsApiState {
  final List<Project> projects = [];
  final List<Task> tasks = [];

  List<Object> get props => [projects, tasks];
}

class DataLoading extends TimesheetsApiState {}

class ProjectsLoaded extends TimesheetsApiState {
  final List<Project> projects;

  ProjectsLoaded(this.projects);
}

class TasksLoaded extends TimesheetsApiState {
  final List<Task> tasks;

  TasksLoaded(this.tasks);
}

class CreateTimerError extends TimesheetsApiState {}
