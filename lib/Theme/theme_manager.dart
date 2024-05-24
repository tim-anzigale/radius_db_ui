import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static ThemeData buildLightTheme() {
    return ThemeData(
      
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.grey.shade200,
      ),
      scaffoldBackgroundColor: Colors.grey.shade200,
      textTheme: GoogleFonts.latoTextTheme(
        ThemeData.light().textTheme,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade200,
        foregroundColor: Colors.grey[800],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey[800]),
        titleTextStyle: TextStyle(
          color: Colors.grey[800],
          fontWeight: FontWeight.bold,
          fontSize: 18, // Adjust size if necessary
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: Colors.grey.shade200,
      ),
    );
  }

  static ThemeData buildDarkTheme() {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.grey.shade900,
      ),
      scaffoldBackgroundColor: Colors.grey.shade900,
      textTheme: GoogleFonts.latoTextTheme(
        ThemeData.dark().textTheme,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.grey[300],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey[300]),
        titleTextStyle: TextStyle(
          color: Colors.grey[300],
          fontWeight: FontWeight.bold,
          fontSize: 18, // Adjust size if necessary
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: Colors.grey.shade900,
      ),
    );
  }
}
