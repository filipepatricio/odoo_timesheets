import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:odoo_apexive/data/api/api.dart';
import 'package:odoo_apexive/data/api/result.dart';
import 'package:odoo_apexive/data/models/project.dart';
import 'package:odoo_apexive/data/models/task.dart';
import 'package:odoo_apexive/data/repository/timesheets_repo.dart';
import 'package:odoo_apexive/utils/mock_creators.dart';

class TimesheetsRepoMock extends TimesheetsRepo {
  @override
  Future<Result<List<Project>, Exception>> fetchProjects() async {
    return Success(MockDTO.projects);
  }

  @override
  Future<Result<List<Task>, Exception>> fetchTasks(
      {required Project project}) async {
    return Success(MockDTO.tasks);
  }
}
