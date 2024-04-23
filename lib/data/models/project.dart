// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:odoo_apexive/data/models/data_type.dart';

class Project implements TimesheetsDataType {
  @override
  final int id;
  @override
  final String name;
  final String description;

  Project(
    this.id,
    this.name,
    this.description,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      map['id'] as int,
      map['name'] as String,
      map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(Map<String, dynamic> source) =>
      Project.fromMap(source);
}
