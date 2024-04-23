part of 'timesheets_api_bloc.dart';

sealed class TimesheetsApiEvent extends Equatable {
  const TimesheetsApiEvent();

  @override
  List<Object> get props => [];
}

class LoadProjectsEvent extends TimesheetsApiEvent {
  const LoadProjectsEvent();
}

class LoadTasksEvent extends TimesheetsApiEvent {
  const LoadTasksEvent({required this.project});
  final Project project;
}
