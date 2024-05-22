import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart'; // Import the theme provider

class Filters {
  static const List<String> filterOptions = [
    'Newest',
    'Terminated',
    'Connected',
    'Disconnected'
  ];

  static Widget buildFilterDropdown(
    String? selectedFilter,
    void Function(String?) onChanged, {
    required double width,
    required double fontSize,
  }) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

        return SizedBox(
          width: width + 20, // Increase width to accommodate longer text
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: isDarkMode ? Colors.grey[700]! : Colors.white), // Set border color based on theme
              color: isDarkMode ? Colors.grey[800]! : Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                Text(
                  'Sort by:',
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[300]! : Colors.grey,
                    fontSize: fontSize,
                  ),
                ),
                const SizedBox(width: 8.0), // Add spacing between text and dropdown
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedFilter,
                      onChanged: onChanged,
                      icon: Icon(Icons.arrow_drop_down, color: isDarkMode ? Colors.grey[300]! : Colors.grey),
                      items: filterOptions.map((String filter) {
                        return DropdownMenuItem<String>(
                          value: filter,
                          child: Text(
                            filter,
                            style: TextStyle(
                              fontSize: fontSize,
                              color: isDarkMode ? Colors.grey[300]! : Colors.black,
                            ), // Set the font size and color based on theme
                          ),
                        );
                      }).toList(),
                      isExpanded: true, // Ensure the dropdown uses all available space
                    ),
                  ),
                ),
                if (selectedFilter != null)
                  IconButton(
                    icon: Icon(Icons.clear, size: 18, color: isDarkMode ? Colors.grey[300]! : Colors.grey), // Adjusted icon size
                    padding: EdgeInsets.zero, // Remove padding
                    constraints: BoxConstraints(),
                    onPressed: () => onChanged(null), // Clear the selected filter
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
