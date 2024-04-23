import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:odoo_apexive/data/api/api.dart';
import 'package:odoo_apexive/data/api/custom_exception.dart';
import 'package:odoo_apexive/data/api/result.dart';
import 'package:odoo_apexive/data/models/project.dart';
import 'package:odoo_apexive/data/models/task.dart';
import 'package:odoo_apexive/data/repository/timesheets_repo.dart';

class TimesheetsRepoImpl extends TimesheetsRepo {
  @override
  Future<Result<List<Project>, Exception>> fetchProjects() async {
    final String response =
        await rootBundle.loadString('${API.baseUrl}projects.json');

    //Faking network error with 30% chance
    if (Random().nextInt(10) > 6) {
      return Failure(ResultException("Error fetching projects"));
    }

    final projects = (json.decode(response) as List)
        .map((data) => Project.fromJson(data))
        .toList();

    return Success(projects);
  }

  @override
  Future<Result<List<Task>, Exception>> fetchTasks(
      {required Project project}) async {
    final String response =
        await rootBundle.loadString('${API.baseUrl}tasks-${project.id}.json');

    //Faking network error with 20% chance
    if (Random().nextInt(10) > 7) {
      return Failure(ResultException("Error fetching tasks"));
    }

    final tasks = (json.decode(response) as List)
        .map((data) => Task.fromJson(data))
        .toList();
    return Success(tasks);
  }
}
