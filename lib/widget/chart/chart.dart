import 'package:doctor_appoinment/data_model/record.dart';
import 'package:doctor_appoinment/main.dart';
import 'package:doctor_appoinment/widget/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.recordOfPatient});
  final List<RecordOfPatient> recordOfPatient;
  List<RecordBucket> get buckets {
    return [
      RecordBucket.category(
          allRecords: recordOfPatient, category: Category.general),
      RecordBucket.category(
          allRecords: recordOfPatient, category: Category.emergency),
      RecordBucket.category(
          allRecords: recordOfPatient, category: Category.routinecheck),
    ];
  }

  double get maxtotalfees {
    double maxtotal = 0;
    for (final bucket in buckets) {
      if (bucket.totatlExpense > maxtotal) {
        maxtotal = bucket.totatlExpense;
      }
    }
    return maxtotal;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: isDark
                    ? [
                        kDarkColorScheme.tertiaryContainer.withOpacity(0.5),
                        kDarkColorScheme.tertiaryContainer.withOpacity(0.2)
                      ]
                    : [
                        kColorScheme.tertiaryContainer.withOpacity(0.6),
                        kColorScheme.tertiaryContainer.withOpacity(0.2)
                      ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8,
        ),
        width: double.infinity,
        height: 180,
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (var bucket in buckets)
                    ChartBar(fill: bucket.totatlExpense / maxtotalfees)
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: buckets
                  .map(
                    (bucket) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(categoryicons[bucket.category],
                            color: isDark
                                ? kDarkColorScheme.primary
                                : kColorScheme.primary),
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        ));
  }
}
