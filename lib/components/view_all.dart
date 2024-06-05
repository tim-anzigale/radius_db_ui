import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart'; // Import the theme provider

class ViewAllText extends StatelessWidget {
  final VoidCallback onTap;

  const ViewAllText({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50), // Adjust padding as needed
          child: Text(
            'View All',
            style: TextStyle(
              color: isDarkMode ? Colors.grey[200] : Theme.of(context).primaryColor, // Adjust color based on theme
              fontSize: 14.0, // Adjust font size as needed
              // fontWeight: FontWeight.bold, // Uncomment to make the text bold
            ),
          ),
        ),
      ),
    );
  }
}