import 'package:odoo_apexive/data/models/project.dart';
import 'package:odoo_apexive/data/models/task.dart';

class MockDTO {
  const MockDTO._();

  static List<Project> projects = [
    Project(1, 'Project 1', 'Project 1 description'),
    Project(2, 'Project 2', 'Project 2 description'),
  ];

  static List<Task> tasks = [
    Task(1, 'Task 1', 60),
    Task(2, 'Task 2', 120),
    Task(3, 'Task 3', 180),
  ];
}
