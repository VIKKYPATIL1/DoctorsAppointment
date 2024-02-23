import 'dart:convert';

import 'package:doctor_appoinment/main.dart';
import 'package:doctor_appoinment/widget/chart/chart.dart';
import 'package:doctor_appoinment/widget/list/list_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:doctor_appoinment/data_model/record.dart';
import 'package:doctor_appoinment/widget/new_patient_record.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});
  @override
  State<RecordScreen> createState() {
    return _RecordScreenState();
  }
}

class _RecordScreenState extends State<RecordScreen> {
  final url = Uri.https('doctorsappointment-3ecd8-default-rtdb.firebaseio.com',
      'doctorsAppointment.json');

  void addPatientRecord(RecordOfPatient recordofpatient) {
    http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'name': recordofpatient.name,
          'fees': recordofpatient.fees,
          'date': recordofpatient.date.toString(),
          'category': recordofpatient.category.toString(),
          'problem': recordofpatient.problem,
        },
      ),
    );
    setState(() {
      _registeredpatientrecord.add(recordofpatient);
    });
  }

  void removePatientRecord(RecordOfPatient recordOfPatient) {
    int removedindex = _registeredpatientrecord.indexOf(recordOfPatient);
    setState(() {
      _registeredpatientrecord.remove(recordOfPatient);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 10),
      content: const Text('Record Removed'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredpatientrecord.insert(removedindex, recordOfPatient);
          });
        },
      ),
    ));
  }

  void openOverlayModel() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) =>
          NewPatientRecord(addPatientRecord: addPatientRecord),
    );
  }

  final List<RecordOfPatient> _registeredpatientrecord = [
    RecordOfPatient(
        name: 'Chetan',
        fees: 18,
        date: DateTime.now(),
        category: Category.general,
        problem: 'eye Checkup'),
  ];

  @override
  Widget build(BuildContext context) {
    final widthofDevice = MediaQuery.of(context).size.width;
    final isDarkmode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Widget currentState = Center(
        child: Text(
      'No Entries are available , try adding some',
      style: TextStyle(
          color: isDarkmode
              ? kDarkColorScheme.inverseSurface
              : kColorScheme.inverseSurface),
    ));
    if (_registeredpatientrecord.isNotEmpty) {
      currentState = widthofDevice >= 600
          ? Row(
              children: [
                Expanded(
                    child: Chart(recordOfPatient: _registeredpatientrecord)),
                ListData(
                    registeredrecord: _registeredpatientrecord,
                    removePatientRecord: removePatientRecord),
              ],
            )
          : currentState = Column(
              children: [
                Chart(recordOfPatient: _registeredpatientrecord),
                ListData(
                    registeredrecord: _registeredpatientrecord,
                    removePatientRecord: removePatientRecord),
              ],
            );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Appoinment'),
          actions: [
            IconButton(
                onPressed: openOverlayModel, icon: const Icon(Icons.add_card))
          ],
        ),
        body: currentState);
  }
}
