import 'package:doctor_appoinment/data_model/record.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appoinment/widget/list/list_item.dart';

class ListData extends StatelessWidget {
  const ListData(
      {super.key,
      required this.registeredrecord,
      required this.removePatientRecord});
  final void Function(RecordOfPatient recordOfPatient) removePatientRecord;
  final List<RecordOfPatient> registeredrecord;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: registeredrecord.length,
        itemBuilder: (context, index) => Dismissible(
            key: ValueKey(context),
            onDismissed: (direction) {
              removePatientRecord(registeredrecord[index]);
            },
            child: ListItems(patientrecord: registeredrecord[index])),
      ),
    );
  }
}
