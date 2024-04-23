import 'package:odoo_apexive/data/api/result.dart';
import 'package:odoo_apexive/data/models/project.dart';
import 'package:odoo_apexive/data/models/task.dart';

abstract class TimesheetsRepo {
  Future<Result<List<Project>, Exception>> fetchProjects();
  Future<Result<List<Task>, Exception>> fetchTasks({required Project project});
}
