import 'package:doctor_appoinment/main.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appoinment/data_model/record.dart';

class ListItems extends StatelessWidget {
  const ListItems({super.key, required this.patientrecord});
  final RecordOfPatient patientrecord;
  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Color textColor =
        isDark ? kDarkColorScheme.inverseSurface : kColorScheme.inverseSurface;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  patientrecord.name,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const Spacer(),
                Text(
                  patientrecord.formattedDate,
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  patientrecord.fees.toString(),
                  style: TextStyle(color: textColor),
                ),
                const Spacer(),
                Icon(categoryicons[patientrecord.category])
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              patientrecord.problem,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
