import 'dart:async';

import 'package:flutter/material.dart';
import 'package:odoo_apexive/blocs/bloc_exports.dart';
import 'package:odoo_apexive/data/models/data_type.dart';
import 'package:odoo_apexive/data/models/project.dart';
import 'package:odoo_apexive/data/models/task.dart';
import 'package:odoo_apexive/data/models/task_timer.dart';

class CreateTimerFormBloc extends FormBloc<String, String> {
  CreateTimerFormBloc({
    required TimesheetsApiBloc timesheetsApiBloc,
    required TaskListBloc taskListBloc,
  })  : _timesheetsApiBloc = timesheetsApiBloc,
        _taskListBloc = taskListBloc,
        super(autoValidate: false) {
    _loadProjects();
    addFieldBlocs(fieldBlocs: [
      taskSelectField,
      projectSelectField,
      descriptionTextField,
      isFavoriteCheckBox,
    ]);
  }

  final TimesheetsApiBloc _timesheetsApiBloc;
  final TaskListBloc _taskListBloc;
  late StreamSubscription _timesheetsApiSubscription;

  final taskSelectField = SelectFieldBloc<TimesheetsDataType, dynamic>(
    validators: [FieldBlocValidators.required],
  );
  final projectSelectField = SelectFieldBloc<TimesheetsDataType, dynamic>(
    validators: [FieldBlocValidators.required],
  );
  final descriptionTextField = TextFieldBloc();
  final isFavoriteCheckBox = BooleanFieldBloc();

  @override
  Future<void> close() {
    _timesheetsApiSubscription.cancel();
    return super.close();
  }

  void _loadProjects() {
    _timesheetsApiSubscription =
        _timesheetsApiBloc.stream.listen(_onTimesheetsDataLoaded);
    _timesheetsApiBloc.add(const LoadProjectsEvent());
  }

  void _onTimesheetsDataLoaded(TimesheetsApiState state) {
    debugPrint(state.toString());

    switch (state.runtimeType) {
      case const (ProjectsLoaded):
        final projects = (state as ProjectsLoaded).projects;
        projectSelectField.updateItems([]);
        projectSelectField.updateItems(projects);
        break;
      case const (TasksLoaded):
        final tasks = (state as TasksLoaded).tasks;
        taskSelectField.updateItems([]);
        taskSelectField.updateItems(tasks);
        break;
      default:
        break;
    }
  }

  @override
  void onSubmitting() async {
    try {
      _taskListBloc.add(
        AddTaskTimer(
          taskTimer: TaskTimer(
            task: taskSelectField.state.value as Task,
            project: projectSelectField.state.value as Project,
            description: descriptionTextField.value,
            isFavorite: isFavoriteCheckBox.value,
          ),
        ),
      );

      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure(failureResponse: 'Please fill Task and Project fields');
    }
  }

  void onProjectChanged(TimesheetsDataType? value) {
    if (value != null) {
      _timesheetsApiBloc.add(LoadTasksEvent(project: value as Project));
    }
  }
}
