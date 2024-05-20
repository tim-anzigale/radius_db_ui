import 'package:flutter/material.dart';

class Filters {
  static const List<String> filterOptions = ['Newest', 'Terminated', 'Active'];

  static Widget buildFilterDropdown(
    String? selectedFilter, 
    void Function(String?) onChanged, 
    {required double width, required double fontSize}
  ) {
    return SizedBox(
      width: width + 20, // Increase width to accommodate longer text
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.white), // Set border color to white
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          children: [
            Text(
              'Sort by:',
              style: TextStyle(color: Colors.grey, fontSize: fontSize),
            ),
            const SizedBox(width: 8.0), // Add spacing between text and dropdown
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedFilter,
                  onChanged: onChanged,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  items: filterOptions.map((String filter) {
                    return DropdownMenuItem<String>(
                      value: filter,
                      child: Text(
                        filter,
                        style: TextStyle(fontSize: fontSize), // Set the font size
                      ),
                    );
                  }).toList(),
                  isExpanded: true, // Ensure the dropdown uses all available space
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
