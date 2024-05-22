import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radius_db_ui/components/filters.dart';
import '../theme_provider.dart'; // Import the theme provider

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final String? selectedFilter;
  final ValueChanged<String?> onFilterChanged;
  final double filterWidth;
  final double fontSize;

  const SearchBar({
    Key? key,
    required this.searchController,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.filterWidth,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double searchBarWidth = screenWidth > 600 ? 400 : 250;

    return SizedBox(
      height: 40,
      width: searchBarWidth,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                // Update state in the parent widget
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                prefixIcon: Icon(Icons.search, color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: isDarkMode ? (Colors.grey[700] ?? Colors.grey) : Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: isDarkMode ? (Colors.grey[700] ?? Colors.grey) : Colors.white),
                ),
                filled: true,
                fillColor: isDarkMode ? (Colors.grey[800] ?? Colors.black) : Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              ),
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          const SizedBox(width: 10),
          Filters.buildFilterDropdown(
            selectedFilter,
            (String? newValue) {
              onFilterChanged(newValue);
              // Handle filter logic here based on selected filter
              // For example, you can call a method in the parent widget to handle the filter logic
              // parentWidget.handleFilter(newValue);
            },
            width: filterWidth, // Pass adjusted width
            fontSize: fontSize, // Pass adjusted font size
          ),
        ],
      ),
    );
  }
}
