// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:odoo_apexive/data/models/data_type.dart';

class Task implements TimesheetsDataType {
  @override
  final int id;
  @override
  final String name;
  final int duration; // in seconds

  Task(
    this.id,
    this.name,
    this.duration,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'duration': duration,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      map['id'] as int,
      map['name'] as String,
      map['duration'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(Map<String, dynamic> source) => Task.fromMap(source);
}
