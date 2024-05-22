import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart'; // Import the theme provider

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF2E2E2E) : Colors.grey[200], // Neumorphic base color
      ),
      child: Text(
        'Hello Admin',
        style: TextStyle(
          fontSize: 12.0, // Font size
          fontWeight: FontWeight.bold, // Font weight
          color: isDarkMode ? Colors.grey[200] : Colors.black, // Text color based on theme
        ),
      ),
    );
  }
}
