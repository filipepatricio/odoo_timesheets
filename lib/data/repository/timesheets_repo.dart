import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:odoo_apexive/data/api/api.dart';
import 'package:odoo_apexive/data/models/project.dart';
import 'package:odoo_apexive/data/models/task.dart';

abstract class TimesheetsRepo {
  Future<List<Project>> fetchProjects();
  Future<List<Task>> fetchTasks({required Project project});
}

class TimesheetsRepoImpl extends TimesheetsRepo {
  @override
  Future<List<Project>> fetchProjects() async {
    final String response =
        await rootBundle.loadString('${API.baseUrl}projects.json');
    final projects = (json.decode(response) as List)
        .map((data) => Project.fromJson(data))
        .toList();

    return projects;
  }

  @override
  Future<List<Task>> fetchTasks({required Project project}) async {
    final String response =
        await rootBundle.loadString('${API.baseUrl}tasks-${project.id}.json');
    final tasks = (json.decode(response) as List)
        .map((data) => Task.fromJson(data))
        .toList();
    return tasks;
  }
}
