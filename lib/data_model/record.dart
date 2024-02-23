import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

enum Category { emergency, routinecheck, general }

final formatter = DateFormat.yMd();
const categoryicons = {
  Category.emergency: Icons.emergency_outlined,
  Category.routinecheck: Icons.route_outlined,
  Category.general: Icons.fact_check_rounded
};

const uuid = Uuid();

class RecordOfPatient {
  RecordOfPatient(
      {required this.name,
      required this.fees,
      required this.date,
      required this.category,
      required this.problem})
      : id = uuid.v4();
  final String id;
  final String name;
  final DateTime date;
  final double fees;
  final Category category;
  final String problem;

  String get formattedDate {
    return formatter.format(date);
  }
}

class RecordBucket {
  RecordBucket({required this.category, required this.recordOfPatient});

  RecordBucket.category(
      {required List<RecordOfPatient> allRecords, required this.category})
      : recordOfPatient = allRecords
            .where((recordofP) => recordofP.category == category)
            .toList();

  final Category category;
  final List<RecordOfPatient> recordOfPatient;

  double get totatlExpense {
    double sum = 0;
    for (var recordsofp in recordOfPatient) {
      sum += recordsofp.fees;
    }
    return sum;
  }
}
