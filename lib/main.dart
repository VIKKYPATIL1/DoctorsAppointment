import 'package:doctor_appoinment/widget/record_screen.dart';
import 'package:flutter/material.dart';

ColorScheme kColorScheme = ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 132, 125, 125).withOpacity(0.5));
ColorScheme kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Color.fromARGB(255, 132, 125, 125).withOpacity(0.5));
void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData().copyWith(
        scaffoldBackgroundColor: kDarkColorScheme.secondaryContainer,
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer.withOpacity(0.8),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 16,
          shadowColor: kDarkColorScheme.inversePrimary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.secondaryContainer,
          ),
        ),
        snackBarTheme: const SnackBarThemeData().copyWith(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: kDarkColorScheme.onPrimaryContainer,
            actionTextColor: kDarkColorScheme.primaryContainer,
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating),
        datePickerTheme: const DatePickerThemeData().copyWith(
            dayStyle:
                TextStyle(decorationColor: kDarkColorScheme.tertiaryContainer)),
        appBarTheme: AppBarTheme(
          actionsIconTheme: const IconThemeData()
              .copyWith(color: kDarkColorScheme.onTertiaryContainer),
          backgroundColor: kDarkColorScheme.primaryContainer,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 16,
          shadowColor: kColorScheme.inversePrimary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.secondaryContainer,
          ),
        ),
        snackBarTheme: const SnackBarThemeData().copyWith(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: kColorScheme.onPrimaryContainer,
            actionTextColor: kColorScheme.primaryContainer,
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating),
        datePickerTheme: const DatePickerThemeData().copyWith(
            dayStyle:
                TextStyle(decorationColor: kColorScheme.tertiaryContainer)),
        appBarTheme: AppBarTheme(
          actionsIconTheme: const IconThemeData()
              .copyWith(color: kColorScheme.onTertiaryContainer),
          backgroundColor: kColorScheme.primaryContainer,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      home: const RecordScreen(),
    ),
  );
}
